import 'package:dio/dio.dart';
import 'package:job_search_app/config/api_config.dart';

Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      queryParameters: {"app_id": appId, "app_key": appKey},
    ),
  );

  return dio;
}
