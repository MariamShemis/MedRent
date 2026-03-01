import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:med_rent/core/constants/strings_keys.dart';

class ApiErrorHandler {
  static String handleDioError(
      DioException error,
      BuildContext context,
      ) {
    if (error.error is SocketException) {
      return StringsKeys.noInternetConnection(context);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return StringsKeys.connectionTimedOut(context);

      case DioExceptionType.badResponse:
        return _messageForStatus(
          error.response?.statusCode,
          context,
        );

      case DioExceptionType.cancel:
        return StringsKeys.requestCancelled(context);

      default:
        return StringsKeys.unexpectedError(context);
    }
  }

  static String _messageForStatus(
      int? statusCode,
      BuildContext context,
      ) {
    switch (statusCode) {
      case 400:
        return StringsKeys.invalidEmailOrPassword(context);
      case 401:
        return StringsKeys.unauthorized(context);
      case 403:
        return StringsKeys.forbidden(context);
      case 404:
        return StringsKeys.resourceNotFound(context);
      case 409:
        return StringsKeys.conflict(context);
      case 500:
        return StringsKeys.serverError(context);
      case 503:
        return StringsKeys.serviceUnavailable(context);
      default:
        return StringsKeys.unexpectedError(context);
    }
  }

  static String handleUnknownError(
      BuildContext context,
      ) {
    return StringsKeys.unexpectedError(context);
  }
}
