import 'package:dio/dio.dart';
import 'package:grocery_app/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import 'dart:developer' as developer;

class AuthRepository {
  AuthRepository();
  Future<void> loginUser(Auth auth) async {
    Dio dio = Dio();

    dio.options.headers = {
      "Content-Type": "application/json",
    };

    var data = {
      "phone": auth.phone,
      "password": auth.password,
      "country": "ETH"
    };
    try {
      var response = await dio.post(ApiEndPoints.login, data: data);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("userToken", response.data['data']['token']);
    } catch (err) {
      throw "Invalid credentials!";
    }
  }
}
