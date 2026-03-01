part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}
final class ForgotPasswordLoading extends ForgetPasswordState {}

final class ForgotPasswordSuccess extends ForgetPasswordState {
  final String message;
  ForgotPasswordSuccess({required this.message});
}

final class ForgotPasswordFailure extends ForgetPasswordState {
  final String errorMessage;
  ForgotPasswordFailure({required this.errorMessage});
}