import 'dart:convert';

import 'package:dio/dio.dart';

import '../constants/network_api.dart';
import '../models/product.dart';

class MyNetworkService {
  // MyNetworkService._internal();
  // static final MyNetworkService _instance = MyNetworkService._internal();
  // factory MyNetworkService() => _instance;

  int count = 0;
  show() {
    print("$count");
    count++;
  }

  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = NetworkAPI.baseURL;
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          // await Future.delayed(Duration(seconds: 10));
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          switch (e.response?.statusCode) {
            case 301:
              break;
            case 401:
              break;
            default:
          }
          return handler.next(e);
        },
      ),
    );

  Future<List<Product>> getProduct() async {
    final response = await _dio.get(NetworkAPI.product);
    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data));
    }
    throw Exception();
  }
}
