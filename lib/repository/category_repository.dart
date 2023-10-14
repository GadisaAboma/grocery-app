import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:grocery_app/bloc/category_bloc.dart/category_state.dart';
import 'package:grocery_app/models/auth.dart';
import 'package:grocery_app/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import 'dart:developer' as developer;

class CategoryRepository {
  CategoryRepository();
  Future loadCategory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String token = pref.getString("userTokenn").toString();
    developer.log(token);
    Dio dio = Dio();

    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      var response = await dio.get(ApiEndPoints.category);
      List<CategoryModel> categories = (response.data['data'] as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList();

      return categories;
    } catch (err) {
      throw "unable to load category";
    }
  }
}
