import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:med_rent/core/error/api_error_handler.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/equipment details/data/models/equipment_availability.dart';
import 'package:med_rent/features/equipment details/data/models/equipment_details_model.dart';
import 'package:med_rent/features/equipment details/data/models/equipment_review.dart';
import 'package:med_rent/features/equipment details/data/models/rating_summary.dart';

class EquipmentDetailsDataSource {
  final ApiClient _apiClient;

  EquipmentDetailsDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<EquipmentDetailsModel> getEquipmentById(int id, BuildContext context) async {
    try {
      final response = await _apiClient.get(
        '/Equipment/$id',
      );

      if (response.statusCode == 200) {
        return EquipmentDetailsModel.fromJson(response.data);
      }

      throw Exception(ApiErrorHandler.handleUnknownError(context));
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleDioError(e, context));
    } catch (_) {
      throw Exception(ApiErrorHandler.handleUnknownError(context));
    }
  }

  Future<List<ReviewModel>> getEquipmentReviews(int id, BuildContext context) async {
    try {
      final response = await _apiClient.get(
        '/Equipment/$id/reviews',
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((json) => ReviewModel.fromJson(json))
              .toList();
        }
        return [];
      }

      throw Exception(ApiErrorHandler.handleUnknownError(context));
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleDioError(e, context));
    } catch (_) {
      throw Exception(ApiErrorHandler.handleUnknownError(context));
    }
  }

  Future<RatingSummaryModel> getRatingSummary(int id, BuildContext context) async {
    try {
      final response = await _apiClient.get(
        '/Equipment/$id/rating-summary',
      );

      if (response.statusCode == 200) {
        return RatingSummaryModel.fromJson(response.data);
      }

      throw Exception(ApiErrorHandler.handleUnknownError(context));
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleDioError(e, context));
    } catch (_) {
      throw Exception(ApiErrorHandler.handleUnknownError(context));
    }
  }

  Future<AvailabilityModel> getEquipmentAvailability(int id, BuildContext context) async {
    try {
      final response = await _apiClient.get(
        '/Equipment/$id/availability',
      );

      if (response.statusCode == 200) {
        return AvailabilityModel.fromJson(response.data);
      }

      throw Exception(ApiErrorHandler.handleUnknownError(context));
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handleDioError(e, context));
    } catch (_) {
      throw Exception(ApiErrorHandler.handleUnknownError(context));
    }
  }

  String _formatImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return '';

    String formattedUrl = imageUrl.replaceAll('\\', '/');

    if (!formattedUrl.startsWith('/')) {
      formattedUrl = '/$formattedUrl';
    }

    return formattedUrl;
  }
}