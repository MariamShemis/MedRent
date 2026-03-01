part of 'verification_code_cubit.dart';

@immutable
sealed class VerificationCodeState {}

final class VerificationCodeInitial extends VerificationCodeState {}

final class VerificationCodeLoading extends VerificationCodeState {}

final class VerificationCodeSuccess extends VerificationCodeState {
  final String message;
  VerificationCodeSuccess(this.message);
}

final class VerificationCodeFailure extends VerificationCodeState {
  final String errorMessage;
  VerificationCodeFailure(this.errorMessage);
}
