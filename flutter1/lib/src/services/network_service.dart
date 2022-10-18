import 'package:dio/dio.dart';

class NetworkService {
  NetworkService._internal();
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  static final Dio _dio = Dio();

  getProducts() async {
    // final response = await _dio.get(NetworkAPI.product);
    // if (response.statusCode == 200) {
    //   return productFromJson(jsonEncode(response.data));
    // }

    final response = await _dio.get("https://cmcrud.herokuapp.com/products");
    if (response.statusCode == 200){

    }
  }

}