import 'package:dio/dio.dart';
import 'package:job_search_app/core/error/error_messages.dart';

String getErrorMessage(dynamic exception) {
  if (exception is DioException) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ErrorMessages.connectionTimeout;

      case DioExceptionType.connectionError:
        return ErrorMessages.connectionError;

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        if (statusCode != null && statusCode >= 500) {
          return ErrorMessages.serverError;
        } else {
          return ErrorMessages.unexpectedError;
        }

      default:
        return ErrorMessages.unexpectedError;
    }
  } else {
    return ErrorMessages.unexpectedError;
  }
}
