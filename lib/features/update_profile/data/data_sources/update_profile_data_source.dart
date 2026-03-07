import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:med_rent/core/error/api_error_handler.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/main_layout/profile/data/models/profile_model.dart';
import 'package:med_rent/features/update_profile/data/models/update_profile_model.dart';

class UpdateProfileDataSource {
  final Dio dio;

  UpdateProfileDataSource(this.dio);

  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest request,
      BuildContext context,
      ) async {
    try {
      final token = await SessionService.getAuthToken();

      final response = await dio.put(
        "http://graduationprojectapi.somee.com/api/Profile",
        data: request.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return UpdateProfileResponse.fromJson(response.data);

    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioError(e, context);
    } catch (_) {
      throw ApiErrorHandler.handleUnknownError(context);
    }
  }

  Future<UploadImageResponse> uploadProfileImage(
      File imageFile,
      BuildContext context,
      ) async {
    try {
      final token = await SessionService.getAuthToken();

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path),
      });

      final response = await dio.post(
        "http://graduationprojectapi.somee.com/api/Profile/upload-image",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return UploadImageResponse.fromJson(response.data);

    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioError(e, context);
    } catch (_) {
      throw ApiErrorHandler.handleUnknownError(context);
    }
  }

  Future<ProfileModel?> getProfile(BuildContext context) async {
    try {
      final token = await SessionService.getAuthToken();
      final response = await dio.get(
        "http://graduationprojectapi.somee.com/api/Profile",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioError(e, context);
    } catch (_) {
      throw ApiErrorHandler.handleUnknownError(context);
    }

    return null;
  }
}