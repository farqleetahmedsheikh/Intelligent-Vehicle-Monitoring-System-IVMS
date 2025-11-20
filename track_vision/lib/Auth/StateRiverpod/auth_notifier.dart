
import 'dart:convert';

import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_vision/Auth/StateRiverpod/auth_state.dart';
import 'package:track_vision/Auth/admin_model.dart';
import 'package:track_vision/Auth/auth_services.dart';
import 'package:track_vision/Auth/user_model.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
    (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final _secureStorage = const FlutterSecureStorage();

  AuthNotifier() : super(AuthState());

  // load tokens & user from local storage
  Future<void> loadFromStorage() async {
    state = AuthState(status: AuthStatus.loading);
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    final access = await _secureStorage.read(key: 'access');
    final refresh = await _secureStorage.read(key: 'refresh');
// user sign up conditions
    if (userJson != null && access != null) {
      final user = UserModel.fromJson(jsonDecode(userJson));
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
        admin: null,
        access: access,
        refresh: refresh,
      );
    } else {
      state = AuthState(status: AuthStatus.unauthenticated);
    }
  }

  // save to storage
  Future<void> _saveToStorage({
    UserModel? user,
    required String access,
    String? refresh}) async {
    final prefs = await SharedPreferences.getInstance();
    if(user != null){
      await prefs.setString('user', jsonEncode(user.toJson()));
    }
    await _secureStorage.write(key: 'access', value: access);
    if (refresh != null && refresh.isNotEmpty) await _secureStorage.write(key: 'refresh', value: refresh);
    }


  // LogIn
  Future<void> login(String email, String password) async {
    state = AuthState(
        status: AuthStatus.loading,
        user: null,
        admin: null,
        access: null,
        refresh: null,
        message: null
    );
    try {
      final res = await AuthServices.login(email, password);
      print('Login Response: $res');

      final bool isSuccess = (res['success'] == true) || (res['status']);

      if (!isSuccess) {
        state = AuthState(
          status: AuthStatus.authenticated,
          user: null,
          admin: null,
          access: null,
          refresh: null,
          message: res['message'] ?? res['errorMessage'] ?? 'Login failed',
        );
        return;
      }
      final data = (res['data'] is Map<String, dynamic>) ? res['data'] : res;

      final userJson = data['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(userJson);

      final access = (data['access'] ?? data['token'] ?? '') as String;
      final refresh = (data['refresh'] ?? '') as String;

      await _saveToStorage(
          user: user,
          refresh: refresh,
          access: access);
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
        admin: null,
        access: access,
        refresh: refresh,
        message: null,
      );
      print("Login user.role = ${user.role}");
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        user: null,
        admin: null,
        access: null,
        refresh: null,
        message: 'Login error: $e',
      );
    }
  }

      // SignUp for user
      Future<void> signupUser(Map<String, dynamic> payload) async {
        state = state.copyWith(status: AuthStatus.loading,
            message: null);
        final res = await AuthServices.signupUser(payload);
        if (res['success'] == true) {
          state = state.copyWith(
              status: AuthStatus.unauthenticated,
              message: 'User signed up successfully'
          );
        } else {
          state = state.copyWith(
            status: AuthStatus.error,
            message: res['message'].toString(),
          );
        }
      }

      // Sign Up for admin
      Future<void> signupAdmin(Map<String, dynamic> payload) async {
        state = state.copyWith(status: AuthStatus.loading,
            message: null);
        final res = await AuthServices.signupAdmin(payload);
        if (res['success'] == true) {
          state = state.copyWith(
              status: AuthStatus.unauthenticated,
              message: 'Admin Signup Successfully'
          );
        } else {
          state = state.copyWith(
            status: AuthStatus.error,
            message: res['message'].toString(),
          );
        }
      }

      // Forgot Password
      Future<void> forgotPassword(String email) async {
        state = state.copyWith(
          status: AuthStatus.loading,
          message: null,
        );
        final res = await AuthServices.forgotPassword(email);
        if (res['success'] == true) {
          state = state.copyWith(
            status: AuthStatus.unauthenticated,
            message: 'OTP sent to email',
          );
        } else {
          state = state.copyWith(status: AuthStatus.error,
              message: res['message']?.toString());
        }
      }

      // Verify OTP
      Future<void> verifyOtp(String email, String otp) async {
        state = state.copyWith(
            status: AuthStatus.loading,
            message: null
        );
        final res = await AuthServices.verifyOtp(email, otp);
        if (res['success'] == true) {
          state = state.copyWith(
              status: AuthStatus.unauthenticated,
              message: 'OTP verified, reset your password.');
        } else {
          state = state.copyWith(
              status: AuthStatus.error,
              message: res['message'] ?? 'Something went wrong'
          );
        }
      }

      // reset password
      Future<void> resetPassword(String newPassword,
          String confirmPassword) async {
        state = state.copyWith(
          status: AuthStatus.loading,
          message: null,
        );
        final res = await AuthServices.resetPassword(
            newPassword, confirmPassword);
        if (res['success'] == true) {
          state = state.copyWith(
              status: AuthStatus.unauthenticated,
              message: 'Password reset Successfully, please login'
          );
        }
      }

      // Logout
      Future<void> logout() async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('user');
        await prefs.remove('admin');
        await _secureStorage.delete(key: 'access');
        await _secureStorage.delete(key: 'refresh');
        state = AuthState(status: AuthStatus.unauthenticated);
      }
    }

