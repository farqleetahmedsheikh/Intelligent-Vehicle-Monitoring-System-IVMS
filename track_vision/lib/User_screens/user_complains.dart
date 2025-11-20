
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Auth/user/user_state.dart';

import '../utils/constant_colors.dart' show ConstantColors;

class UserComplains extends ConsumerStatefulWidget{
  const UserComplains({super.key});

  @override
  ConsumerState<UserComplains> createState() => _UserComplainsState();
}

class _UserComplainsState extends ConsumerState<UserComplains>{
 late final TextEditingController _searchController ;

  @override
  void initState(){
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final complaints = ref.watch(filteredComplaintsProvider);
    return Scaffold(
      backgroundColor: ConstantColors.textLightMode.withOpacity(0.5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title text
            const Text("Search Complaints", style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: ConstantColors.textDarkMode
            ),),
            const SizedBox(height: 25,),
            // Search  Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by Plate, Chassis Number, CNIC, Email...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white70,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              onChanged: (value){
                ref.read(complaintSearchQueryProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 20,),
            Expanded(
                child: complaints.isEmpty
                    ? const Center(
                  child: Text(
                    "No results found",
                    style: TextStyle(color: Colors.grey),
                  ),
                ) : ListView.separated(
                  itemCount: complaints.length,
                  separatorBuilder: (_, __) =>
                  const Divider(height: 16),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(complaints[index]),
                    );
                  },
                ),),


          ],
        ),
      ),
    );
  }
}