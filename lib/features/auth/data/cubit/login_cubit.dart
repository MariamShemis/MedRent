import 'package:bloc/bloc.dart';
import 'package:med_rent/features/auth/data/data_sources/auth_remote_data.dart';
import 'package:med_rent/features/auth/data/models/login_model.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
   Future<void> loginCubit({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      var model = await AuthRemoteData.login(email: email, password: password);
      emit(LoginSuccess(model: model));
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}

