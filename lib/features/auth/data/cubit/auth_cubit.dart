import 'package:bloc/bloc.dart';
import 'package:med_rent/features/auth/data/data_sources/auth_remote_data.dart';
import 'package:med_rent/features/auth/data/models/login_model.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginCubit({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      var model = await AuthRemoteData.login(email: email, password: password);
      emit(AuthSuccess(model: model));
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
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
      await AuthRemoteData.register(name: name, email: email, password: password, phone: phone);
      emit(AuthInitial());
    }catch(e){
      emit(AuthFailure(errorMessage: e.toString()));
    }
    }
  }

