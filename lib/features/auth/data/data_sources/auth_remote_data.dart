import 'dart:io';
import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/network/network_checker.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/auth/data/models/login_model.dart';

class AuthRemoteData {
  final ApiClient _apiClient;

  AuthRemoteData({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final hasInternet =
    await NetworkChecker.hasInternetConnection();

    if (!hasInternet) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: const SocketException('No Internet'),
      );
    }

    final response = await _apiClient.post(
      '/Auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      final loginModel =
      LoginModel.fromJson(response.data);

      await SessionService.saveUserData(
        userId: loginModel.userId,
        name: loginModel.name,
        role: loginModel.role,
        email: email,
        token: loginModel.token,
      );

      return loginModel;
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final hasInternet =
    await NetworkChecker.hasInternetConnection();

    if (!hasInternet) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: const SocketException('No Internet'),
      );
    }

    final response = await _apiClient.post(
      '/Auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return;
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  Future<String> forgotPassword({
    required String email,
  }) async {
    final hasInternet =
    await NetworkChecker.hasInternetConnection();

    if (!hasInternet) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: const SocketException('No Internet'),
      );
    }

    final response = await _apiClient.post(
      '/Auth/forgot-password',
      data: {
        "email": email,
      },
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return "Success";
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  Future<String> verifyCode({
    required String email,
    required String code,
  }) async {
    final hasInternet =
    await NetworkChecker.hasInternetConnection();

    if (!hasInternet) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: const SocketException('No Internet'),
      );
    }

    final response = await _apiClient.post(
      '/Auth/verify-code',
      queryParameters: {
        'email': email,
        'code': code,
      },
    );

    if (response.statusCode == 200) {
      return "Success";
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  Future<void> newPassword({
    required String email,
    required String newPassword,
  }) async {
    final hasInternet =
    await NetworkChecker.hasInternetConnection();

    if (!hasInternet) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: const SocketException('No Internet'),
      );
    }

    final response = await _apiClient.post(
      '/Auth/reset-password',
      queryParameters: {
        'email': email,
        'newPassword': newPassword,
      },
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  Future<void> logout() async {
    await SessionService.logout();
  }

  Future<bool> isLoggedIn() async {
    return SessionService.isLoggedIn();
  }
}