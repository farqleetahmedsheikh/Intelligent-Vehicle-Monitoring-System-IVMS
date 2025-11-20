import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// state for user bottom navbar
final uBottomNavIndexProvider = StateProvider<int>((ref) => 0);

// state for user AppBar
final uNotificationCountProvider = StateProvider<int>((ref) => 0);
final uUserNameProvider = StateProvider<String>((ref) => "F");

// state for user complaints
final complaintSearchQueryProvider = StateProvider<String>((ref) => '');

// compalints(dummy data)
final allComplaintsProvider = Provider<List<String>>((ref){
  return [
    'Plate ABC-123 | CNIC 12345-6789012-3',
    'Plate XYZ-987 | CNIC 98765-4321098-7',
    'Chassis 1HGCM82633A004352 | Email user@test.com',
  ];
});

// Filtered complaints based on search text
final filteredComplaintsProvider = Provider<List<String>>((ref) {
  final query = ref.watch(complaintSearchQueryProvider);
  final all = ref.watch(allComplaintsProvider);

  if(query.trim().isEmpty) return all;

  return all.where(
      (item) => item.toLowerCase().contains(query.toLowerCase()),
  ).toList();
});