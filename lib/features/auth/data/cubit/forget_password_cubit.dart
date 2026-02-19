import 'package:bloc/bloc.dart';
import 'package:med_rent/core/error/api_error_handler.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/auth/data/data_sources/auth_remote_data.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  late final AuthRemoteData _authRemoteData;
  ForgetPasswordCubit() : super(ForgetPasswordInitial()){
    _authRemoteData = AuthRemoteData(apiClient: ApiClient());
  }

  Future<void> sendOtp({required String email}) async {
    emit(ForgotPasswordLoading());
    try {
      final message = await _authRemoteData.forgotPassword(email: email);
      emit(ForgotPasswordSuccess(message: message));
    } on ApiException catch (error) {
      emit(ForgotPasswordFailure(errorMessage: error.key));
    } catch (e) {
      emit(ForgotPasswordFailure(errorMessage: 'Unexpected error occurred'));
    }
  }


}
