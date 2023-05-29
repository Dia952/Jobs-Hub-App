import 'package:flutter/material.dart';
import 'package:jobs_hub/Models/user_model.dart';
import 'package:jobs_hub/Services/auth_service.dart';

import '../Models/user_singleton.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<User?> login(String username, String password) async {
    try {
      User? user = await _authService.login(username, password);
      UserSingleton().user = user!;
      return user;
    } catch (error) {
      debugPrint('Login Error: $error');
      return null;
    }
  }

  Future<User?> register(String firstName, String lastName, String username,
      String email, String phone, String password) async {
    try {
      User? user = await _authService.register(
          firstName, lastName, username, email, phone, password);
      UserSingleton().user = user!;

      return user;
    } catch (error) {
      debugPrint('Registration Error: $error');
      return null;
    }
  }
}
