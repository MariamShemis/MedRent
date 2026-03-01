import 'package:bloc/bloc.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/main_layout/profile/data/data_sources/profile_data.dart';
import 'package:med_rent/features/main_layout/profile/data/models/profile_model.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileData profileData;
  ProfileCubit(this.profileData) : super(ProfileInitial());

  Future<void> getProfileData() async {
    emit(ProfileLoading());
    try {
    final token = await SessionService.getAuthToken(); 
    
    if (token != null && token.isNotEmpty) {
      final profile = await profileData.fetchProfile(token);
      emit(ProfileSuccess(profile));
    } else {
      emit(ProfileError("Session expired"));
    }
  } catch (e) {
    emit(ProfileError(e.toString()));
  }
  }

  Future<void> updateProfileImage(String filePath) async {
 
 emit(ProfileLoading());
    try {
      final token = await SessionService.getAuthToken();
      if (token != null && token.isNotEmpty) {
        await profileData.uploadProfileImage(token, filePath);
        await getProfileData();
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
