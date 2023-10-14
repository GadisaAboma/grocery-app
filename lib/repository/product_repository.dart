import 'package:dio/dio.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/single_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import 'dart:developer' as developer;

class ProductRepository {
  ProductRepository();
  Future laodLatestProducts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String token = pref.getString("userToken").toString();
    Dio dio = Dio();
    developer.log(token);

    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    developer.log(ApiEndPoints.products);
    try {
      var response = await dio.get(ApiEndPoints.products);

      List<ProductModel> prodcuts = (response.data['data'] as List)
          .map((category) => ProductModel.fromJson(category))
          .toList();

      return prodcuts;
    } catch (err) {
      developer.log(err.toString());
      throw "unable to load products";
    }
  }

  Future laodSingleProduct(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String token = pref.getString("userToken").toString();
    Dio dio = Dio();
    developer.log(token);

    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    developer.log(ApiEndPoints.products);
    try {
      var response = await dio.get('${ApiEndPoints.products}/$id');
      developer.log(response.data['data'].toString());
      SingleProductModel product =
          SingleProductModel.fromJson(response.data['data']);

      return product;
    } catch (err) {
      throw "unable to load products";
    }
  }
}
