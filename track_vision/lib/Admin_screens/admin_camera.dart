import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Admin_screens/widgets/admin_ipcamera.dart';

import '../utils/constant_colors.dart';

class AdminCamera extends ConsumerStatefulWidget{
  @override
  ConsumerState<AdminCamera> createState() => _AdminCameraState();
}

class _AdminCameraState extends ConsumerState<AdminCamera>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: ConstantColors.textLightMode.withOpacity(0.5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Scan Vehicle Live", style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: ConstantColors.textDarkMode
                ),),
                Text("Select an option to proceed:", style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54
                ),)
              ],
            ),

            const SizedBox(height: 30,),

            // Scan Options
            // Connect IP Camera
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => IPCamera()));
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Connect IP Camera", style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: ConstantColors.textDarkMode
                    ),),
                    Text("Connect with existing IP camera to see live.", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54
                    ),)
                  ],
                ),
              ),
            ),
        const SizedBox(height: 30,),
        // Scan with mobile
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Scan with Mobile", style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: ConstantColors.textDarkMode
                  ),),
                  Text("Install the App from the AppStore/PlayStore", style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54
                  ),),
                  Text("to scan with your mobile camera.", style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54
                  ),)
                ],
              ),
            )




          ],
        ),
      ),
    );
  }
}