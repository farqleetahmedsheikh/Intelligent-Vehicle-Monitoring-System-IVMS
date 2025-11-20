import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Auth/user/user_state.dart';
import 'package:track_vision/User_screens/user_appbar.dart';
import 'package:track_vision/User_screens/user_camera.dart';
import 'package:track_vision/User_screens/user_complains.dart';
import 'package:track_vision/User_screens/user_dashboard.dart';

import '../utils/constant_colors.dart';

class UserBottomNavbar extends ConsumerStatefulWidget{
  const UserBottomNavbar({super.key});

  @override
  ConsumerState<UserBottomNavbar> createState() => _UserBottomNavbarState();
}

class _UserBottomNavbarState extends ConsumerState<UserBottomNavbar>{

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.feedback_outlined,
    Icons.camera_alt_outlined
  ];

  final List<String> _labels = [
    'Home',
    'Complaints',
    'Camera'
  ];

  @override
  Widget build(BuildContext context){
    final selectedIndex = ref.watch(uBottomNavIndexProvider);

    final userPages = [
      UserDashboard(),
      UserComplains(),
      UserCamera(),
    ];

    return Scaffold(
      appBar: UserAppbar(),
      body: userPages[selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => ref.read(uBottomNavIndexProvider.notifier).state = index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ConstantColors.textLightMode,
        unselectedItemColor: ConstantColors.textLightMode.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 15, color: ConstantColors.textLightMode),
        unselectedLabelStyle: const TextStyle(fontSize: 15, color: ConstantColors.textLightMode),
        backgroundColor: ConstantColors.primaryBlue,
        items:  List.generate(_icons.length, (index) {
          final bool isSelected = selectedIndex == index;
          return BottomNavigationBarItem(
              label: _labels[index],
              icon: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: isSelected ? Colors.white.withOpacity(0.25) : Colors
                        .transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Icon(_icons[index],
                  color: isSelected? Colors.white : Colors.white70,
                  size: 30,),
              )
          );
        }
        ),
      ),
    );
  }
}