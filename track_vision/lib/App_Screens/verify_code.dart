import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_notifier.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_state.dart';

import '../utils/constant_colors.dart';

class VerifyCode extends ConsumerStatefulWidget{
  final String email;
  const VerifyCode({super.key, required this.email});

  @override
  ConsumerState<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends ConsumerState<VerifyCode>{
  String otp = '';

  @override
  Widget build(BuildContext context){
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const SizedBox(height: 80,),
              // App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Verify ", style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: ConstantColors.textDarkMode
                  ),),
                  //
                  const Text("Code", style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: ConstantColors.primaryBlue
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              const Text("Please enter the code we just send to email", style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black54
              ),),
                  const SizedBox(height: 100,),
                  // Form
                   OtpTextField(
                     numberOfFields: 4,
                     borderColor: Colors.grey,
                     showFieldAsBox: true,
                     onSubmit: (String code){
                       otp = code;
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
                         "Resend on 2:00",
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
                         if(otp.isEmpty){
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text("Please enter OTP")),
                           );
                           return;
                         }
                         await authNotifier.verifyOtp(widget.email, otp);
                         if(authState.status != AuthStatus.error){
                           Navigator.pushNamed(context, '/new-password/');
                         }
                       },
                       style: ElevatedButton.styleFrom(
                         backgroundColor: ConstantColors.primaryBlue,
                       ),
                       child: authState.status == AuthStatus.loading ? const CircularProgressIndicator(
                         color: ConstantColors.primaryBlue,) : const Text("Verify Code",
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           color: ConstantColors.textLightMode,
                         ),
                       ),
                     ),
                   ),
                  if(authState.message != null) Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0
                      ),
                  child: Text(authState.message!, style: TextStyle(
                    color: authState.status == AuthStatus.error? Colors.red : Colors.green
                  ),
                  ),)
              ]
            ),
        ),
    ),
    );
  }
}