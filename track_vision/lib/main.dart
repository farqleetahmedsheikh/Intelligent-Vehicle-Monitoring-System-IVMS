import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_vision/App_Screens/Admin_screens/admin_alerts.dart';
import 'package:track_vision/App_Screens/Admin_screens/admin_bottomnavbar.dart';
import 'package:track_vision/App_Screens/Admin_screens/admin_dashboard.dart';
import 'package:track_vision/App_Screens/Admin_screens/admin_vehicles.dart';
import 'package:track_vision/App_Screens/forgot_password.dart';
import 'package:track_vision/App_Screens/log_in.dart';
import 'package:track_vision/App_Screens/new_password.dart';
import 'package:track_vision/App_Screens/sign_up.dart';
import 'package:track_vision/App_Screens/splash_screen.dart';
import 'package:track_vision/App_Screens/verify_code.dart';
import 'package:track_vision/Auth/user/mobile_camerastate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // wire up Riverpod
  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Track Vision',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SignUp(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login/':
            return MaterialPageRoute(builder: (_) => LogIn());
          case '/signup/':
            return MaterialPageRoute(builder: (_) => SignUp());
          case '/forgot-password/':
            return MaterialPageRoute(builder: (_) => ForgotPassword());
          case '/verify-code/':
            final email = settings.arguments as String;
            return MaterialPageRoute(builder: (_) => VerifyCode(email: email));
          case '/new-password/':
            return MaterialPageRoute(builder: (_) => NewPassword());
          // Admin page routed
          case '/admin-dashboard/':
            return MaterialPageRoute(builder: (_) => AdminDashboard());
          case '/admin-vehicles/':
            return MaterialPageRoute(builder: (_) => AdminVehicles());
          case '/admin_alerts/':
            return MaterialPageRoute(builder: (_) => AdminAlerts());
          case '/admin-bottomNavbar/':
            return MaterialPageRoute(builder: (_) => AdminBottomNavbar());
          default:
            return null;
        }
      },
    );
  }
}
