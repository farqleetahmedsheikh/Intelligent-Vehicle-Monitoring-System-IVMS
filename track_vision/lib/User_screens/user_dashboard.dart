import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Admin_screens/widgets/detection_section.dart';
import '../Admin_screens/widgets/google_map.dart';
import '../Admin_screens/widgets/overview_cards.dart';

class UserDashboard extends StatelessWidget{
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dashboard Overview text
                  Text("Dashboard Overview", style: TextStyle(
                    color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,
                  ),),

                  // Overview Card
                  OverviewCards(),
                  //Latest Detections
                  DetectionSection(),
                  const SizedBox(height: 10,),
                  // Map Preview
                  Text("Map Preview", style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black
                  ),),
                  SizedBox(height: 15,),
                  GoogleMap(),

                ]
            ),
          ),
        )
    );
  }
}