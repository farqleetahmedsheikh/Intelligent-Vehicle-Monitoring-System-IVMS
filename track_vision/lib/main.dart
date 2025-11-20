import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Admin_screens/admin_alerts.dart';
import 'package:track_vision/Admin_screens/admin_bottomnavbar.dart';
import 'package:track_vision/Admin_screens/admin_dashboard.dart';
import 'package:track_vision/Admin_screens/admin_vehicles.dart';
import 'package:track_vision/App_Screens/forgot_password.dart';
import 'package:track_vision/App_Screens/log_in.dart';
import 'package:track_vision/App_Screens/new_password.dart';
import 'package:track_vision/App_Screens/sign_up.dart';
import 'package:track_vision/App_Screens/verify_code.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_notifier.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_state.dart';
import 'package:track_vision/User_screens/user_dashboard.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // wire up Riverpod
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authNotifierProvider.notifier).loadFromStorage();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Track Vision',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const LogIn(),
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
              return MaterialPageRoute(
                  builder: (_) => VerifyCode(email: email));
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
        }
    );
  }
}






