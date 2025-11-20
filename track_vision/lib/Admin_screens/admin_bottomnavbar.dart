import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Admin_screens/admin_appbar.dart';
import 'package:track_vision/Admin_screens/admin_camera.dart';
import 'package:track_vision/Admin_screens/admin_complains.dart';
import 'package:track_vision/Admin_screens/admin_dashboard.dart';
import 'package:track_vision/Auth/admin/admin_state.dart';
import 'package:track_vision/utils/constant_colors.dart';

class AdminBottomNavbar extends ConsumerStatefulWidget{
  const AdminBottomNavbar({super.key});

  @override
  ConsumerState<AdminBottomNavbar> createState() => _AdminBottomNavbarState();
}

class _AdminBottomNavbarState extends ConsumerState<AdminBottomNavbar>{

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
    final selectedIndex = ref.watch(bottomNavIndexProvider);


    final adminPages =  [
      AdminDashboard(),
      AdminComplains(),
      AdminCamera(),
    ];
    return Scaffold(
      appBar: AdminAppbar(),
      body: adminPages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => ref.read(bottomNavIndexProvider.notifier).state = index,
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