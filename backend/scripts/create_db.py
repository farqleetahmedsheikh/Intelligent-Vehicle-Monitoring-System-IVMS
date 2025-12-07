#!/usr/bin/env python3
"""Create a MySQL/MariaDB database from the command line.

Usage:
  python create_db.py -u root -p mypassword -H localhost -P 3306 -d visiontrack_db

This script uses `mysql-connector-python` (install with `pip install mysql-connector-python`).
"""
import argparse
import sys

try:
    import mysql.connector
except Exception:
    print("Missing dependency: please run `pip install mysql-connector-python`")
    raise


def create_database(user, password, host, port, db_name):
    try:
        conn = mysql.connector.connect(user=user, password=password, host=host, port=port)
        cursor = conn.cursor()
        sql = (
            f"CREATE DATABASE IF NOT EXISTS `{db_name}` "
            "CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        )
        cursor.execute(sql)
        print(f"Database '{db_name}' created or already exists.")
    except mysql.connector.Error as err:
        print('Error while creating database:', err)
        return False
    finally:
        try:
            cursor.close()
        except Exception:
            pass
        try:
            conn.close()
        except Exception:
            pass
    return True


def main():
    parser = argparse.ArgumentParser(description='Create MySQL/MariaDB database')
    parser.add_argument('-u', '--user', required=True, help='DB user (e.g. root)')
    parser.add_argument('-p', '--password', required=True, help='DB password')
    parser.add_argument('-H', '--host', default='localhost', help='DB host')
    parser.add_argument('-P', '--port', type=int, default=3306, help='DB port')
    parser.add_argument('-d', '--db', required=True, help='Database name to create')

    args = parser.parse_args()

    ok = create_database(args.user, args.password, args.host, args.port, args.db)
    if not ok:
        sys.exit(1)


if __name__ == '__main__':
    main()
