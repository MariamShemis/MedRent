part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final LoginModel loginModel;
  AuthSuccess({required this.loginModel});
}

final class AuthRegisterSuccess extends AuthState {
  final String message;
  AuthRegisterSuccess({required this.message});
}

final class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure({required this.errorMessage});
}

final class AuthLoggedIn extends AuthState {}

final class AuthLoggedOut extends AuthState {}