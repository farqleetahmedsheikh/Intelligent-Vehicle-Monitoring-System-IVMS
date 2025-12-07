import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/App_Screens/Admin_screens/admin_bottomnavbar.dart';
import 'package:track_vision/App_Screens/log_in.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_notifier.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_state.dart';
import 'package:track_vision/App_Screens/User_screens/user_bottomnavbar.dart';
import 'package:track_vision/utils/constant_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use Future.microtask to avoid modifying provider during build
    Future.microtask(() => _initializeApp());
  }

  Future<void> _initializeApp() async {
    final startTime = DateTime.now();
    // Load auth state from storage
    await ref.read(authNotifierProvider.notifier).loadFromStorage();

    final elapsed = DateTime.now().difference(startTime);
    final remaining = Duration(seconds: 1) - elapsed;

    if (remaining.inMilliseconds > 0) {
      await Future.delayed(remaining);
    }
    if (!mounted) return;

    // Check auth status and navigate
    final authState = ref.read(authNotifierProvider);

    if (authState.status == AuthStatus.authenticated) {
      // Check if user is admin or regular user
      if (authState.user?.role == 'admin' ||
          authState.user?.role == 'Admin(Organization)') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminBottomNavbar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UserBottomNavbar()),
        );
      }
    } else {
      // Not authenticated, go to login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LogIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.primaryBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset("assets/images/applogo.png", height: 120, width: 120),
            const SizedBox(height: 20),
            // App Name
            const Text(
              "Track Vision",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Tagline
            const Text(
              "Intelligent Vehicle Monitoring",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 40),
            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
