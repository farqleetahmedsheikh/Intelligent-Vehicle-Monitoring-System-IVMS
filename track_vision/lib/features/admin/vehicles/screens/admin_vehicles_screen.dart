import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/shared/providers/data_providers.dart';
import 'package:track_vision/features/admin/vehicles/widgets/detection_details.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:track_vision/core/config/constants.dart';

class AdminVehicles extends ConsumerStatefulWidget {
  const AdminVehicles({super.key});

  @override
  ConsumerState<AdminVehicles> createState() => _AdminVehiclesState();
}

class _AdminVehiclesState extends ConsumerState<AdminVehicles> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final detectionsAsync = ref.watch(detectionsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Vehicle Detections",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Search Bar
            TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search by device ID or location...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Detections List
            Expanded(
              child: detectionsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, st) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 50,
                      ),
                      const SizedBox(height: 10),
                      Text('Error: $err'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(detectionsProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
                data: (detections) {
                  // Filter detections - using deviceId for search since plateNumber doesn't exist
                  var filtered = detections.where((d) {
                    final matchesSearch =
                        _searchQuery.isEmpty ||
                        (d.deviceId?.toLowerCase().contains(
                              _searchQuery.toLowerCase(),
                            ) ??
                            false) ||
                        (d.locationText?.toLowerCase().contains(
                              _searchQuery.toLowerCase(),
                            ) ??
                            false);
                    // Note: Detection model doesn't have status field, showing all
                    return matchesSearch;
                  }).toList();

                  if (filtered.isEmpty) {
                    return const Center(
                      child: Text(
                        'No detections found',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(detectionsProvider);
                    },
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final detection = filtered[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 2,
                          child: ListTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.accentBlue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: detection.detectedImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        detection.detectedImage!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(
                                              Icons.directions_car,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                      ),
                                    )
                                  : const Icon(
                                      Icons.directions_car,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                            ),
                            title: Text(
                              'Detection #${detection.id}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(timeago.format(detection.detectedAt)),
                                if (detection.locationText != null)
                                  Text(
                                    detection.locationText!,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                              ],
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetectionDetailPage(detection),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
