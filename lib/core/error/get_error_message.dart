import 'package:dio/dio.dart';
import 'package:job_search_app/core/error/error_messages.dart';

String getErrorMessage(dynamic exception) {
  if (exception is DioException) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ErrMsgs.connectionTimeout;

      case DioExceptionType.connectionError:
        return ErrMsgs.connectionError;

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        if (statusCode != null && statusCode >= 500) {
          return ErrMsgs.serverError;
        } else {
          return ErrMsgs.unexpectedError;
        }

      default:
        return ErrMsgs.unexpectedError;
    }
  } else {
    return ErrMsgs.unexpectedError;
  }
}
