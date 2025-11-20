import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/utils/constant_colors.dart';

class UserCamera extends ConsumerStatefulWidget{
  @override
  ConsumerState<UserCamera> createState() => _UserCameraState();
}

class _UserCameraState extends ConsumerState<UserCamera>{
  @override
  Widget build(BuildContext context){
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
                  Text("Scan Vehicle Live", style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: ConstantColors.textDarkMode
                  ),),
                  Text("Select an option to proceed:", style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54
                  ),)
                ],
              ),

          const SizedBox(height: 25,),

          // Scan Options
            Container(
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
                  Text("Scan with Mobile Camera", style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: ConstantColors.textDarkMode
                  ),),
                  Text("Open your mobile Camera now", style: TextStyle(
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