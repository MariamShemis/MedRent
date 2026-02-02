import 'package:dio/dio.dart';
import 'package:med_rent/features/equipment%20details/presentation/view_model/equipment_availability.dart';
import 'package:med_rent/features/equipment%20details/presentation/view_model/equipment_details_model.dart';
import 'package:med_rent/features/equipment%20details/presentation/view_model/equipment_review.dart';
import 'package:med_rent/features/equipment%20details/presentation/view_model/rating_summary.dart';

class EquipmentDetailsDataSource {
  final Dio _dio = Dio();

  Future<EquipmentDetailsModel> getEquipmentById(int id) async {
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
        throw Exception('Failed to load equipment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching equipment: $e');
    }
  }

  Future<List<ReviewModel>> getEquipmentReviews(int id) async {
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
          return (response.data as List)
              .map((json) => ReviewModel.fromJson(json))
              .toList();
        }
        return [];
      } else {
        throw Exception('Failed to load reviews: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching reviews: $e');
    }
  }

  Future<RatingSummaryModel> getRatingSummary(int id) async {
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
        throw Exception('Failed to load rating summary: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching rating summary: $e');
    }
  }

  Future<AvailabilityModel> getEquipmentAvailability(int id) async {
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
        throw Exception('Failed to load availability: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching availability: $e');
    }
  }

  Future<Map<String, dynamic>> getAllEquipmentData(int id) async {
    try {
      final equipment = await getEquipmentById(id);
      final reviews = await getEquipmentReviews(id);
      final ratingSummary = await getRatingSummary(id);
      final availability = await getEquipmentAvailability(id);

      return {
        'equipment': equipment,
        'reviews': reviews,
        'ratingSummary': ratingSummary,
        'availability': availability,
      };
    } catch (e) {
      throw Exception('Failed to load all equipment data: $e');
    }
  }
}