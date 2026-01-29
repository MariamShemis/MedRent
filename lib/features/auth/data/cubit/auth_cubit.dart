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
      if (isLoggedIn) {
        emit(AuthLoggedIn());
      }
    } catch (e) {
      print('Error checking initial auth: $e');
    }
  }

  Future<void> loginCubit({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final loginModel = await _authRemoteData.login(
        email: email,
        password: password,
      );

      emit(AuthSuccess(loginModel: loginModel));

    } on ApiException catch (error) {
      emit(AuthFailure(errorMessage: error.key));
    } catch (error) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> registerCubit({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(AuthLoading());

    try {
      final message = await _authRemoteData.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );

      emit(AuthRegisterSuccess(message: message));

    } on ApiException catch (error) {
      emit(AuthFailure(errorMessage: error.key));
    } catch (error) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> logoutCubit() async {
    emit(AuthLoading());

    try {
      await _authRemoteData.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(errorMessage: 'Logout failed: ${e.toString()}'));
    }
  }
}