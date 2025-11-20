import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_vision/Auth/admin/detection_provider.dart';


class DetectionDetailPage extends StatelessWidget{
  final Detection detection ;
  const DetectionDetailPage(this.detection,{super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Car image
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage("assets/images/car.png"),  // <-- EDIT THIS PATH LATER
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Plate
            Text(
              detection.plate,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Time ago
            Text(
              detection.timeAgo,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Delete button
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context, "delete");
              },
              child: const Text("Delete Detection"),
            ),

            const SizedBox(height: 30),

            // JSON view
            const Text(
              "Raw Data:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                detection.toString(),
                style: const TextStyle(fontFamily: "monospace"),
              ),
            ),
          ],
        ),
      ),

    );
  }
}