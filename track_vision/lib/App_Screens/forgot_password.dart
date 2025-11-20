import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_notifier.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_state.dart';

import '../utils/constant_colors.dart';

class ForgotPassword extends ConsumerStatefulWidget{
  const ForgotPassword({super.key});
 @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}
class _ForgotPasswordState extends ConsumerState<ForgotPassword>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context){
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
       body:  SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const SizedBox(height: 80,),
              // App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Forgot", style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: ConstantColors.textDarkMode
                  ),),
                  //
                  const Text("Password", style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: ConstantColors.primaryBlue
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              const Text("Please type your email below", style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54
              ),),
              const Text("and we will give you OTP code", style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54
              ),),
              const SizedBox(height: 100,),
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
                       if(value == null || value.isEmpty) {
                         return 'Please enter your email';
                       }
                       final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2.4}$');
                       if(!emailRegex.hasMatch(value)){
                         return 'Please enter a valid email';
                       }
                       return null;
                     },
                   ),
                   const SizedBox(height: 15,),
                   // use phone number text_button
                   Align(
                     alignment: Alignment.centerRight,
                     child: TextButton(
                       onPressed: () {
                         Navigator.pushNamed(context, '/forgot-password/');
                       },
                       child: const Text(
                         "Use phone number?",
                         style: TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.bold,
                           color: ConstantColors.primaryBlue,
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(height: 50.0),
                   // Send Code Button
                   SizedBox(
                     width: MediaQuery.of(context).size.width,
                     height: 50.0,
                     child: ElevatedButton(
                       onPressed: () async{
                         if(_formKey.currentState!.validate()){
                           await authNotifier.forgotPassword(_email.text.trim());
                           if(authState.status != AuthStatus.error){
                             Navigator.pushNamed(context, '/verify-code/', arguments: _email.text.trim());
                           }
                         }
                       },
                       style: ElevatedButton.styleFrom(
                         backgroundColor: ConstantColors.primaryBlue,
                       ),
                       child: authState.status == AuthStatus.loading ? const CircularProgressIndicator(
                         color: ConstantColors.backgroundLight,) : const Text("Send Code",
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           color: ConstantColors.textLightMode,
                         ),
                       ),
                     ),
                   ),
                  // auth successful or error message
                  if(authState.message != null) Padding(padding: EdgeInsets.only(top: 12),
                  child: Text(authState.message!,
                  style: TextStyle(color: authState.status == AuthStatus.error? Colors.red : Colors.green),
                  ),),
            ],
            ),
        ),
    ),
    );
  }
}