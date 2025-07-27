import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';

class AuthController {
  static UserModel? userModel;
  static String? accessToken;

  static const String _userDataKey = 'user-data';
  static const String _tokenKey = 'token';

  // Save user data and token to SharedPreferences
  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    await sharedPreferences.setString(_tokenKey, token);
    userModel = model;
    accessToken = token;
  }

  // Update user data and token in SharedPreferences
  static Future<void> updateUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    await sharedPreferences.setString(_tokenKey, token);
    userModel = model;
    accessToken = token;
  }

  // Load user data and token from SharedPreferences
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userModel = UserModel.fromJson(
      jsonDecode(sharedPreferences.getString(_userDataKey)!),
    );
    accessToken = sharedPreferences.getString(_tokenKey);
  }

  // Check if user is logged in based on stored token
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    if (token != null) {
      await getUserData();
      return true;
    } else {
      return false;
    }
  }

  // Clear user session
  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
    userModel = null;
  }
}
