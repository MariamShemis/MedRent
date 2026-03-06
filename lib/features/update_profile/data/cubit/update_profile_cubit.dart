import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/main_layout/profile/data/models/profile_model.dart';
import 'package:med_rent/features/update_profile/data/cubit/update_profile_state.dart';
import 'package:med_rent/features/update_profile/data/data_sources/update_profile_data_source.dart';
import 'package:med_rent/features/update_profile/data/models/update_profile_model.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileDataSource remoteDataSource;

  UpdateProfileCubit(this.remoteDataSource) : super(UpdateProfileInitial());

  Future<void> updateProfile(
    UpdateProfileRequest request,
    BuildContext context,
  ) async {
    emit(UpdateProfileLoading());
    try {
      final response = await remoteDataSource.updateProfile(request, context);
      final oldData = await SessionService.getUserData();
      await SessionService.saveUserData(
        userId: oldData?['userId'] ?? 0,
        role: oldData?['role'] ?? '',
        name: request.name,
        email: request.email,
        phone: request.phone,
      );
      SessionService.setSessionGender(request.gender);
      SessionService.setSessionDateOfBirth(request.dateOfBirth);
      await SessionService.printStoredData();
      emit(UpdateProfileSuccess(response.message));
    } catch (error) {
      emit(UpdateProfileError(error.toString()));
    }
  }

  Future<void> uploadImage(File imageFile, BuildContext context) async {
    emit(UpdateProfileLoading());
    try {
      final response = await remoteDataSource.uploadProfileImage(
        imageFile,
        context,
      );
      emit(UpdateProfileImageUploaded(response.imageUrl));
    } catch (error) {
      emit(UpdateProfileError(error.toString()));
    }
  }

  Future<ProfileModel?> getProfile(BuildContext context) async {
    emit(UpdateProfileLoading());
    try {
      final profile = await remoteDataSource.getProfile(context);
      emit(UpdateProfileSuccess("Profile loaded"));
      return profile;
    } catch (error) {
      emit(UpdateProfileError(error.toString()));
      return null;
    }
  }
}
