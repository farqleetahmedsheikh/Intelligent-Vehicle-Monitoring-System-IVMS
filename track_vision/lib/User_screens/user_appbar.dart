import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Auth/user/user_state.dart';
import 'package:track_vision/User_screens/user_alert.dart';

import '../utils/constant_colors.dart';

class UserAppbar extends ConsumerStatefulWidget implements PreferredSizeWidget{
  const UserAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  ConsumerState<UserAppbar> createState() => _UserAppbarState();
}

class _UserAppbarState extends ConsumerState<UserAppbar>{
  @override
  Widget build(BuildContext context){

    final notificationCount = ref.watch(uNotificationCountProvider);
    final userName = ref.watch(uUserNameProvider);

    return Container(
      height: widget.preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: ConstantColors.primaryBlue,
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )]
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // App Logo + Title + Subtitle
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("assets/images/applogo.png",
                    height: 50, width: 50, fit: BoxFit.cover,),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Title
                    const Text("Track Vision", style: TextStyle(
                        color: ConstantColors.textLightMode,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                    const SizedBox(height: 2,),
                    const Text("Intelligent Vehicle Monitoring",
                      style: TextStyle(color: ConstantColors.textLightMode,
                          fontSize: 12),)
                  ],
                )
              ],
            ),

            // Notification + Profile Section
            Row(
              children: [
                Stack(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => UserAlerts()));
                    },
                        icon: Icon(Icons.notifications_outlined,
                          color: Colors.white, size: 35,)),
                    if(notificationCount > 0)
                      Positioned(
                          right: 0, top: 2,
                          child: Container(
                            height: 8, width: 8,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle
                            ),
                          ))
                  ],
                ),
                const SizedBox(width: 15,),
                // Profile section
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text("F", style: TextStyle(
                        color: ConstantColors.primaryBlue, fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
}