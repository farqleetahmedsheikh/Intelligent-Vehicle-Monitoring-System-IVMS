#!/usr/bin/env python3
"""Inspect and optionally remove admin migration rows from `django_migrations`.

Use this if `admin.0001_initial` is recorded as applied but depends on `users.0001_initial`.
WARNING: Always backup your database before running this script.

Usage:
  python backend\scripts\remove_admin_migration_rows.py

The script will:
 - show whether `users.0001_initial` exists in `django_migrations`
 - show whether `admin` migrations exist in `django_migrations`
 - list DB tables (sample)
 - ask for confirmation before deleting `admin` migration rows

After deleting `admin` rows, run `python manage.py migrate` to apply all migrations in order.
"""
import os
import sys

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend.backend.settings')

try:
    import django
    django.setup()
except Exception as e:
    print('Error setting up Django:', e)
    sys.exit(1)

from django.db import connection


def list_migration(app=None):
    with connection.cursor() as c:
        if app:
            c.execute("SELECT app, name, applied FROM django_migrations WHERE app=%s ORDER BY applied", [app])
        else:
            c.execute("SELECT app, name, applied FROM django_migrations ORDER BY applied")
        return c.fetchall()


def list_tables(limit=50):
    with connection.cursor() as c:
        c.execute("SHOW TABLES;")
        rows = [r[0] for r in c.fetchall()]
        return rows[:limit]


def delete_admin_rows():
    with connection.cursor() as c:
        c.execute("DELETE FROM django_migrations WHERE app=%s", ["admin"])


def main():
    print('*** Inspecting migration state')
    users = list_migration('users')
    admin = list_migration('admin')

    print('\nUsers migrations (in django_migrations):')
    if users:
        for r in users:
            print(' ', r)
    else:
        print('  <none>')

    print('\nAdmin migrations (in django_migrations):')
    if admin:
        for r in admin:
            print(' ', r)
    else:
        print('  <none>')

    print('\nSample tables in DB:')
    tables = list_tables()
    print(' ', tables)

    if not admin:
        print('\nNo admin migration rows found — nothing to delete.')
        return

    print('\nWARNING: Deleting admin migration rows will make Django think admin migrations are unapplied.\n'
          'This is safe if you plan to re-run `python manage.py migrate` after marking/applying `users` migrations.\n')

    resp = input('Type DELETE to remove all admin rows from django_migrations, or anything else to abort: ')
    if resp.strip() != 'DELETE':
        print('Aborted by user. No changes made.')
        return

    try:
        delete_admin_rows()
        print('Deleted admin migration rows from django_migrations.')
        print('Now run: python manage.py migrate')
    except Exception as e:
        print('Failed to delete admin rows:', e)
        sys.exit(1)


if __name__ == '__main__':
    main()
