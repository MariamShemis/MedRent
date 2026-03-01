import 'package:bloc/bloc.dart';

import 'package:med_rent/features/auth/data/data_sources/auth_remote_data.dart';
import 'package:meta/meta.dart';

part 'verification_code_state.dart';

class VerificationCodeCubit extends Cubit<VerificationCodeState> {
  final AuthRemoteData authRemoteData;

  VerificationCodeCubit(this.authRemoteData) : super(VerificationCodeInitial());

  Future<void> verifyCode({required String email, required String code}) async {
    emit(VerificationCodeLoading());
    try {
      final result = await authRemoteData.verifyCode(email: email, code: code);
      emit(VerificationCodeSuccess(result));
    } catch (e) {
      emit(VerificationCodeFailure(e.toString()));
    }
  }
}