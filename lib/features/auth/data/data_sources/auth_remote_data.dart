import 'dart:io';
import 'package:dio/dio.dart';
import 'package:med_rent/core/constants/strings_keys.dart';
import 'package:med_rent/core/error/api_error_handler.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/network/network_checker.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/auth/data/models/login_model.dart';

class AuthRemoteData {
  final ApiClient _apiClient;

  AuthRemoteData({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final hasInternet = await NetworkChecker.hasInternetConnection();
    if (!hasInternet) {
      throw ApiException(
        message: 'No internet connection',
        key: StringKeys.noInternetConnection,
      );
    }

    try {
      final response = await _apiClient.post(
        '/Auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginModel = LoginModel.fromJson(response.data);

        await SessionService.saveUserData(
          userId: loginModel.userId,
          name: loginModel.name,
          role: loginModel.role,
          email: email,
          token: loginModel.token,
        );

        return loginModel;
      } else {
        throw ApiException(
          message: 'Login failed with status: ${response.statusCode}',
          key: _handleStatusCodeKey(response.statusCode),
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? 'Dio error occurred',
        key: _handleDioErrorKey(e),
      );
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        key: StringKeys.unexpectedError,
      );
    }
  }

  Future<String> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final hasInternet = await NetworkChecker.hasInternetConnection();
    if (!hasInternet) {
      throw ApiException(
        message: 'No internet connection',
        key: StringKeys.noInternetConnection,
      );
    }

    try {
      final response = await _apiClient.post(
        '/Auth/register',
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Registration successful! Please login.";
      } else {
        throw ApiException(
          message: 'Registration failed with status: ${response.statusCode}',
          key: _handleStatusCodeKey(response.statusCode, isRegister: true),
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final errorData = e.response!.data;

        if (statusCode == 400) {
          if (errorData.toString().contains('Email exists') ||
              errorData.toString().contains('Email is already registered')) {
            throw ApiException(
              message: 'Email already exists',
              key: 'Email already exists',
            );
          }
        }

        throw ApiException(
          message: errorData?.toString() ?? 'Registration failed',
          key: _handleDioErrorKey(e, isRegister: true),
        );
      }

      throw ApiException(
        message: e.message ?? 'Network error',
        key: _handleDioErrorKey(e, isRegister: true),
      );
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        key: StringKeys.unexpectedError,
      );
    }
  }
  static String _handleDioErrorKey(DioException error, {bool isRegister = false}) {
    if (error.error is SocketException) {
      return StringKeys.noInternetConnection;
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return StringKeys.connectionTimedOut;

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        return _handleStatusCodeKey(statusCode, isRegister: isRegister);

      case DioExceptionType.cancel:
        return StringKeys.requestCancelled;

      default:
        return StringKeys.unexpectedError;
    }
  }

  static String _handleStatusCodeKey(int? statusCode, {bool isRegister = false}) {
    switch (statusCode) {
      case 400:
        return isRegister ? 'Email already exists' : StringKeys.invalidEmailOrPassword;
      case 401:
        return StringKeys.unauthorized;
      case 404:
        return StringKeys.resourceNotFound;
      case 500:
        return StringKeys.serverError;
      case 503:
        return StringKeys.serviceUnavailable;
      default:
        return StringKeys.unexpectedError;
    }
  }

  Future<void> logout() async {
    await SessionService.logout();
  }

  Future<bool> isLoggedIn() async {
    return await SessionService.isLoggedIn();
  }

  Future<String> forgotPassword({required String email}) async {
    
    final hasInternet = await NetworkChecker.hasInternetConnection();
    if (!hasInternet) {
      throw ApiException(
        message: 'No internet connection',
        key: StringKeys.noInternetConnection,
      );
    }

    try {
      final response = await _apiClient.post(
        '/Auth/forgot-password', 
        data: {
          "email": email, 
        }, 
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "A verification code has been sent to your email."; 
      } else {
        throw ApiException(
          message: 'Failed to send OTP',
          key: _handleStatusCodeKey(response.statusCode),
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? 'Dio error',
        key: _handleDioErrorKey(e),
      );
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        key: StringKeys.unexpectedError,
      );
    }
  }

 Future<String> verifyCode({required String email, required String code}) async {
    final hasInternet = await NetworkChecker.hasInternetConnection();
    if (!hasInternet) {
      throw ApiException(
        message: 'No internet connection',
        key: StringKeys.noInternetConnection,
      );
    }

    try {
      final response = await _apiClient.post(
        '/Auth/verify-code',
        queryParameters: {
          'email': email,
          'code': code,
        },
      );

      if (response.statusCode == 200) {
        return "Success";
      } else {
        throw ApiException(
          message: 'Invalid Code',
          key: _handleStatusCodeKey(response.statusCode),
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? 'Dio error',
        key: _handleDioErrorKey(e),
      );
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        key: StringKeys.unexpectedError,
      );
    }
  }

  Future<void> newPassword({required String email, required String newPassword}) async {
    final hasInternet = await NetworkChecker.hasInternetConnection();
    if (!hasInternet) {
      throw ApiException(
        message: 'No internet connection',
        key: StringKeys.noInternetConnection,
      );
    }

    try {
      await _apiClient.post(
        '/Auth/reset-password', 
        queryParameters: {
          'email': email,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? 'Error resetting password',
        key: _handleDioErrorKey(e),
      );
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        key: StringKeys.unexpectedError,
      );
    }
  }



}


