// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/App_Screens/User_screens/widgets/search_complaints.dart';
import 'package:track_vision/App_Screens/User_screens/widgets/submit_complains.dart';
import '../../utils/constant_colors.dart' show ConstantColors;

class UserComplains extends ConsumerStatefulWidget {
  const UserComplains({super.key});

  @override
  ConsumerState<UserComplains> createState() => _UserComplainsState();
}

class _UserComplainsState extends ConsumerState<UserComplains> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.textLightMode.withOpacity(0.5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vehicle Complaints",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ConstantColors.textDarkMode,
                  ),
                ),
                Text(
                  "Select an option to proceed:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Submit Complaint
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserComplainsSubmit(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Submit Complaint",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ConstantColors.textDarkMode,
                      ),
                    ),
                    Text(
                      "Report a new stolen or lost vehicle.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),

                    //
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Search Complaints
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserComplainsSearch(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Search Complaint",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ConstantColors.textDarkMode,
                      ),
                    ),
                    Text(
                      "Check status or details of existing",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "complaints.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
