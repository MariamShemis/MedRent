import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/core/error/api_error_handler.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/auth/data/data_sources/auth_remote_data.dart';
import 'package:med_rent/features/auth/data/models/login_model.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late final AuthRemoteData _authRemoteData;

  AuthCubit() : super(AuthInitial()) {
    _authRemoteData = AuthRemoteData(apiClient: ApiClient());
    _checkInitialAuth();
  }

  Future<void> _checkInitialAuth() async {
    try {
      final isLoggedIn = await _authRemoteData.isLoggedIn();
      if (isLoggedIn) emit(AuthLoggedIn());
    } catch (e) {
      emit(AuthFailure(errorMessage: 'Failed to check login status'));
    }
  }

  Future<void> loginCubit({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoading());
    try {
      final loginModel = await _authRemoteData.login(
        email: email,
        password: password,
      );
      emit(AuthSuccess(loginModel: loginModel));
    } on DioException catch (error) {
      final msg = ApiErrorHandler.handleDioError(error, context);
      emit(AuthFailure(errorMessage: msg));
    } catch (error) {
      emit(
        AuthFailure(errorMessage: ApiErrorHandler.handleUnknownError(context)),
      );
    }
  }

  Future<void> registerCubit({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) async {
    emit(AuthLoading());
    try {
      await _authRemoteData.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      emit(AuthRegisterSuccess(message: 'Registration successful'));
    } on DioException catch (error) {
      final msg = ApiErrorHandler.handleDioError(error, context);
      emit(AuthFailure(errorMessage: msg));
    } catch (error) {
      emit(
        AuthFailure(errorMessage: ApiErrorHandler.handleUnknownError(context)),
      );
    }
  }

  Future<void> logoutCubit({required BuildContext context}) async {
    emit(AuthLoading());
    try {
      await _authRemoteData.logout();
      emit(AuthLoggedOut());
    } catch (error) {
      emit(AuthFailure(errorMessage: 'Logout failed: ${error.toString()}'));
    }
  }
}
