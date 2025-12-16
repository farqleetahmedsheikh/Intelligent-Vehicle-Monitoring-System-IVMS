import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:track_vision/core/services/api_service.dart';
import 'package:track_vision/shared/providers/auth_notifier.dart';
import 'package:track_vision/features/user/complaints/widgets/complaint_card.dart';
import 'package:track_vision/features/user/complaints/widgets/complaint_detail_modal.dart';

class MyComplaintsScreen extends ConsumerStatefulWidget {
  const MyComplaintsScreen({super.key});

  @override
  ConsumerState<MyComplaintsScreen> createState() => _MyComplaintsScreenState();
}

class _MyComplaintsScreenState extends ConsumerState<MyComplaintsScreen> {
  bool _isLoading = true;
  List<dynamic> _complaints = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final authState = ref.read(authNotifierProvider);
      final email = authState.user?.email;

      if (email == null) {
        setState(() {
          _error = 'User email not found';
          _isLoading = false;
        });
        return;
      }

      // Call API to fetch user complaints
      final response = await AuthServices.getUserComplaints(email);

      setState(() {
        _complaints = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load complaints: $e';
        _isLoading = false;
      });
    }
  }

  void _viewComplaintDetails(dynamic complaint) {
    showDialog(
      context: context,
      builder: (context) => ComplaintDetailModal(complaint: complaint),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "My Complaints",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Content
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 50,
                          ),
                          const SizedBox(height: 10),
                          Text(_error!),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _fetchComplaints,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : _complaints.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'No complaints posted yet.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _fetchComplaints,
                      child: ListView.builder(
                        itemCount: _complaints.length,
                        itemBuilder: (context, index) {
                          final complaint = _complaints[index];
                          return ComplaintCard(
                            complaint: complaint,
                            onView: _viewComplaintDetails,
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
