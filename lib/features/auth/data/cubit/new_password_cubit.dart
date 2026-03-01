import 'package:bloc/bloc.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/auth/data/data_sources/auth_remote_data.dart';
import 'package:meta/meta.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  late final AuthRemoteData _authRemoteData;

  NewPasswordCubit() : super(NewPasswordInitial()) {
    _authRemoteData = AuthRemoteData(apiClient: ApiClient());
  }

  Future<void> newPassword({required String email, required String newPassword}) async {
    emit(NewPasswordLoading());
    try {
      await _authRemoteData.newPassword(
        email: email, 
        newPassword: newPassword,
      );
      emit(NewPasswordSuccess("Password reset successfully!"));
    } catch (e) {
      emit(NewPasswordFailure(e.toString()));
    }
  }
}