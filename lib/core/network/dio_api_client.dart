import 'package:dio/dio.dart';
import 'package:movies_app/core/network/api_constant.dart';

class DioApiClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseURL,
      ),
    );
    return _dio!;
  }
}