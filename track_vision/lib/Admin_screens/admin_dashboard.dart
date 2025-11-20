import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_vision/Admin_screens/widgets/detection_section.dart';
import 'package:track_vision/Admin_screens/widgets/google_map.dart';
import 'package:track_vision/Admin_screens/widgets/overview_cards.dart';

import '../utils/constant_colors.dart';

class AdminDashboard extends StatefulWidget{
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Dashboard Overview text
            Text("Admin Dashboard Overview", style: TextStyle(
             color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold,
            ),),
              const SizedBox(height: 10,),

              // Overview Card
              OverviewCards(),
              const SizedBox(height: 20,),
              //Latest Detections
              DetectionSection(),
              const SizedBox(height: 20,),
              // Map Preview
              Text("Map Preview", style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black
              ),),
              SizedBox(height: 10,),
              GoogleMap(),

          ]
          ),
        ),
      )
    );
  }
}

