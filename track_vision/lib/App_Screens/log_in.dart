import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Admin_screens/admin_bottomnavbar.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_notifier.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_state.dart';
import 'package:track_vision/User_screens/user_bottomnavbar.dart';
import 'package:track_vision/User_screens/user_dashboard.dart';
import 'package:track_vision/utils/constant_colors.dart';

class LogIn extends ConsumerStatefulWidget {
  const LogIn({super.key});

  @override
  ConsumerState<LogIn> createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      // Sign In Page UI/body
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60,),
              // AppLogo
              Image.asset("assets/images/applogo.png", height: 100, width: 100,),
              const SizedBox(height: 40,),
              // App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Log", style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: ConstantColors.textDarkMode
                  ),),
                //
                  const Text("In", style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: ConstantColors.primaryBlue
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              const Text("Welcome back, login to your account!", style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54
              ),),
             const SizedBox(height: 50,),
              // Email text field
               TextFormField(
                 decoration: const InputDecoration(
               labelText: 'Email',
                 labelStyle: TextStyle(
                   fontSize: 14,
                   color: ConstantColors.textDarkMode,
                 ),
                 prefixIcon: Icon(Icons.email_outlined, size: 20.0),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                 ),
               ),
                 controller: _email,
                 keyboardType: TextInputType.emailAddress,
                 validator: (value){
                   if(value == null || value.isEmpty){
                     return 'Please enter your email';
                   }
                   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                   if(!emailRegex.hasMatch(value)) {
                     return 'Please enter a valid email address';
                   }
                   return null;
                 }
                             ),
                         const SizedBox(height: 20.0),
                         // Password Text Field
                         TextFormField(
                           decoration: const InputDecoration(
                             labelText: 'Password',
                             labelStyle: TextStyle(
                               fontSize: 14,
                               color: ConstantColors.textDarkMode,
                             ),
                             prefixIcon: Icon(Icons.lock_outlined, size: 20.0),
                             suffixIcon: Icon(
                               Icons.visibility_off_outlined,
                               size: 20.0,
                             ),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.all(Radius.circular(20.0)),
                             ),
                           ),
                           obscureText: true,
                           controller: _password,
                           keyboardType: TextInputType.text,
                           validator: (value){
                             if(value == null || value.isEmpty){
                               return 'Please enter your password';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(height: 15.0),
                         // forgot Password button
                         Align(
                           alignment: Alignment.centerRight,
                           child: TextButton(
                             onPressed: () {
                               Navigator.pushNamed(context, '/forgot-password/');
                             },
                             child: const Text(
                               "Forgot password?",
                               style: TextStyle(
               fontSize: 14,
               fontWeight: FontWeight.bold,
               color: ConstantColors.primaryBlue,
                               ),
                             ),
                           ),
                         ),
                         const SizedBox(height: 50.0),
                         // Sign In Button
                         SizedBox(
                           width: MediaQuery.of(context).size.width,
                           height: 50.0,
                           child: ElevatedButton(
                             onPressed: () async {
                               if (_formKey.currentState!.validate()) {
                                 await authNotifier.login(
                                   _email.text.trim(),
                                   _password.text.trim(),
                                 );

                                 // Read the *updated* state after login
                                 final newState = ref.read(authNotifierProvider);
                                 print('status = ${newState.status} user = ${newState.user} admin = ${newState.admin}');

                                 if (newState.status == AuthStatus.authenticated && newState.user != null) {
                                   final role = newState.user!.role;
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(content: Text("Login successful!")),
                                   );

                                   // Navigate based on role
                                   if (role == 'admin') {
                                     // Admin: go to admin dashboard / bottom navbar
                                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminBottomNavbar()));
                                     // or '/admin-bottomNavbar/' if that’s your main admin screen
                                   } else {
                                     // User: go to user dashboard
                                     Navigator.pushReplacement(
                                       context,
                                       MaterialPageRoute(builder: (_) => const UserBottomNavbar()),
                                     );
                                     // or define a named route '/user-dashboard/' and use pushReplacementNamed
                                   }
                                 } else if (newState.status == AuthStatus.error) {
                                   // Optionally show error from authState
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(content: Text(newState.message ?? 'Login failed')),
                                   );
                                 }
                               }
                             },

                             style: ElevatedButton.styleFrom(
                               backgroundColor: ConstantColors.primaryBlue,
                             ),
                             child: authState.status== AuthStatus.loading ? const CircularProgressIndicator(
                               color: ConstantColors.backgroundLight,):
                             const Text("Log In",
                               style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.bold,
               color: ConstantColors.textLightMode,
                               ),
                             ),
                           ),
                         ),

               SizedBox(height: 10,),
               // Already have an account text
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Don't have an account?",),
                   TextButton(onPressed: (){
                     Navigator.pushNamed(context, '/signup/');
                   },
                       child: const Text("Signup Now"))
                 ],
               ),
            ],
          ),
        )
      )
    );
  }
}
