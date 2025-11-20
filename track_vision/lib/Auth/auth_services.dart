import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
// ApI Services
class AuthServices{
  static const String baseUrl = "http://10.0.2.2:8000";
  final _storage = const FlutterSecureStorage();

  static Future<Map<String, dynamic>> _post(String endpoint, Map body) async{
    final url = Uri.parse('$baseUrl$endpoint');
    final res = await http.post(
      url,
      headers: {'Content-Type' : 'application/json'},
      body: jsonEncode(body),
    );
    // error
    print('REQUEST to $endpoint: $body');
    print('RESPONSE ${res.statusCode}: ${res.body}');

    final decoded = jsonDecode(res.body);
    if(res.statusCode >= 200 && res.statusCode <300){
      return {'success' : true, 'data': decoded};
    } else {
      return {'success' : false,
      'message': decoded['message'] ?? decoded};
    }
  }
  // LogIn
  static Future<Map<String, dynamic>> login(String email, String password){
    return _post('/login/', {'email' : email, 'password': password});
  }

  // SignUp for user
 static Future<Map<String, dynamic>> signupUser(Map<String, dynamic> payload){
    return _post('/signup/', payload);
 }

 //SignUp for Admin
  static Future<Map<String, dynamic>> signupAdmin(Map<String, dynamic> payload){
    return _post('/signup/', payload);
  }

 //forgot Password
  static Future<Map<String, dynamic>> forgotPassword(String email) {
    return _post('/forgot-password/', {'email': email});
  }

 // verify otp
 static Future<Map<String, dynamic>> verifyOtp(String email, String otp) {
    return _post('/verify-otp/', {'email': email, 'otp': otp});
 }

 // reset Password
static Future<Map<String, dynamic>> resetPassword(String email, String newPassword){
    return _post('/reset-password/', {'email': email, 'new_password': newPassword});
}
}