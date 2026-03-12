import 'package:bloc/bloc.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/main_layout/profile/data/data_sources/profile_data.dart';
import 'package:med_rent/features/main_layout/profile/data/models/profile_model.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileData profileData;
  ProfileModel? _profileModel;
  String? userRole;

  ProfileCubit(this.profileData) : super(ProfileInitial());

  Future<void> getProfileData() async {
    emit(ProfileLoading());
    try {
      final token = await SessionService.getAuthToken();
      if (token != null && token.isNotEmpty) {
        final profile = await profileData.fetchProfile(token);
        _profileModel = profile;
        userRole = await SessionService.getUserRole();

        emit(ProfileSuccess(profile, role: userRole));
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

  Future<void> refreshUserName() async {
    final name = await SessionService.getUserName();
    if (name != null && state is ProfileSuccess) {
      final currentProfile = (state as ProfileSuccess).profileModel;
      final updatedProfile = ProfileModel(
        userId: currentProfile.userId,
        name: name,
        dateOfBirth: currentProfile.dateOfBirth,
        gender: currentProfile.gender,
        phone: currentProfile.phone,
        email: currentProfile.email,
        imageUrl: currentProfile.imageUrl,
      );
      emit(ProfileSuccess(updatedProfile, role: userRole));
    }
  }
}