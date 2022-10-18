import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter1/src/models/Product.dart';

class NetworkService {
  NetworkService._internal();
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  static final Dio _dio = Dio();

  getProducts() async {
    final response = await _dio.get("https://cmcrud.herokuapp.com/products");
    if (response.statusCode == 200){
        final result = productFromJson(jsonEncode(response.data));
        return result;
    }
  }
}