import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search_app/core/constants/api_constants.dart';

final dioProvider = Provider<Dio>((_) {
  return Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      queryParameters: {"app_id": appId, "app_key": appKey},
    ),
  );
});
