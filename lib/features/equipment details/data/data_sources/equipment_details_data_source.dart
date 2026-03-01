import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:med_rent/core/error/api_error_handler.dart';
import 'package:med_rent/features/equipment%20details/data/models/equipment_availability.dart';
import 'package:med_rent/features/equipment%20details/data/models/equipment_details_model.dart';
import 'package:med_rent/features/equipment%20details/data/models/equipment_review.dart';
import 'package:med_rent/features/equipment%20details/data/models/rating_summary.dart';

class EquipmentDetailsDataSource {
  final Dio _dio = Dio();

  Future<EquipmentDetailsModel> getEquipmentById(int id, BuildContext context) async {
    try {
      final response = await _dio.get(
        'http://graduationprojectapi.somee.com/api/Equipment/$id',
        options: Options(
          receiveTimeout: Duration(seconds: 15),
          sendTimeout: Duration(seconds: 15),
        ),
      );

      if (response.statusCode == 200) {
        return EquipmentDetailsModel.fromJson(response.data);
      } else {
        throw Exception(ApiErrorHandler.handleUnknownError(context));
      }
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleDioError(e, context));
    } catch (_) {
      throw Exception(ApiErrorHandler.handleUnknownError(context));
    }
  }

  Future<List<ReviewModel>> getEquipmentReviews(int id, BuildContext context) async {
    try {
      final response = await _dio.get(
        'http://graduationprojectapi.somee.com/api/Equipment/$id/reviews',
        options: Options(
          receiveTimeout: Duration(seconds: 15),
          sendTimeout: Duration(seconds: 15),
        ),
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List).map((json) => ReviewModel.fromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception(ApiErrorHandler.handleUnknownError(context));
      }
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleDioError(e, context));
    } catch (_) {
      throw Exception(ApiErrorHandler.handleUnknownError(context));
    }
  }

  Future<RatingSummaryModel> getRatingSummary(int id, BuildContext context) async {
    try {
      final response = await _dio.get(
        'http://graduationprojectapi.somee.com/api/Equipment/$id/rating-summary',
        options: Options(
          receiveTimeout: Duration(seconds: 15),
          sendTimeout: Duration(seconds: 15),
        ),
      );

      if (response.statusCode == 200) {
        return RatingSummaryModel.fromJson(response.data);
      } else {
        throw Exception(ApiErrorHandler.handleUnknownError(context));
      }
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleDioError(e, context));
    } catch (_) {
      throw Exception(ApiErrorHandler.handleUnknownError(context));
    }
  }

  Future<AvailabilityModel> getEquipmentAvailability(int id, BuildContext context) async {
    try {
      final response = await _dio.get(
        'http://graduationprojectapi.somee.com/api/Equipment/$id/availability',
        options: Options(
          receiveTimeout: Duration(seconds: 15),
          sendTimeout: Duration(seconds: 15),
        ),
      );

      if (response.statusCode == 200) {
        return AvailabilityModel.fromJson(response.data);
      } else {
        throw Exception(ApiErrorHandler.handleUnknownError(context));
      }
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleDioError(e, context));
    } catch (_) {
      throw Exception(ApiErrorHandler.handleUnknownError(context));
    }
  }

  String _formatImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return '';
    String formattedUrl = imageUrl.replaceAll('\\', '/');
    if (!formattedUrl.startsWith('/')) formattedUrl = '/$formattedUrl';
    return "http://graduationprojectapi.somee.com$formattedUrl";
  }
}
