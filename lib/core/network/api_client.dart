import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'token_service.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio _dio;

  factory ApiClient() => _instance;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? 'https://api.hydrogrow.fr/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(_AuthInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: false,
        responseBody: false,
        requestHeader: false,
        responseHeader: false,
        error: true,
      ));
    }
  }

  Dio get dio => _dio;

  Future<Response> get(String path,
          {Map<String, dynamic>? queryParameters}) =>
      _dio.get(path, queryParameters: queryParameters);

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);

  Future<Response> patch(String path, {dynamic data}) =>
      _dio.patch(path, data: data);

  Future<Response> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  Future<Response> delete(String path) => _dio.delete(path);
}

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
