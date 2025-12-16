import 'package:flutter_riverpod/legacy.dart';

// state for admin bottom navbar
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// state for admin AppBar
final notificationCountProvider = StateProvider<int>((ref) => 0);
final userNameProvider = StateProvider<String>((ref) => "F");