import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import '../models/rent_response.dart';
import '../models/rental_summary_response.dart';
import '../models/checkout_response.dart';

class RentPaymentDataSource {
  final ApiClient _apiClient;

  RentPaymentDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<Options> _getOptions() async {
    final token = await SessionService.getAuthToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return Options(headers: headers);
  }

  /// POST /Equipment/rent
  Future<RentResponse> rentEquipment({
    required int equipmentId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final options = await _getOptions();

      final response = await _apiClient.post(
        '/Equipment/rent',
        data: {
          'equipmentId': equipmentId,
          'startDate': startDate,
          'endDate': endDate,
        },
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RentResponse.fromJson(response.data);
      }

      throw Exception('Failed to rent equipment');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Please login again');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// GET /Payment/{rentalId}/summary
  Future<RentalSummaryResponse> getRentalSummary(int rentalId) async {
    try {
      final options = await _getOptions();

      final response = await _apiClient.get(
        '/Payment/$rentalId/summary',
        options: options,
      );

      if (response.statusCode == 200) {
        return RentalSummaryResponse.fromJson(response.data);
      }

      throw Exception('Failed to load rental summary');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Please login again');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// POST /Payment/start-checkout
  Future<CheckoutResponse> startCheckout({
    required int rentalId,
    required String fullName,
    required String phone,
    required String streetAddress,
    required String apartment,
    required String city,
  }) async {
    try {
      final options = await _getOptions();

      final response = await _apiClient.post(
        '/Payment/start-checkout',
        data: {
          'rentalId': rentalId,
          'fullName': fullName,
          'phone': phone,
          'streetAddress': streetAddress,
          'apartment': apartment,
          'city': city,
        },
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CheckoutResponse.fromJson(response.data);
      }

      throw Exception('Failed to start checkout');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Please login again');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// POST /Payment/verify/{paymentIntentId}
  Future<String> verifyPayment(String paymentIntentId) async {
    try {
      final options = await _getOptions();

      final response = await _apiClient.post(
        '/Payment/verify/$paymentIntentId',
        options: options,
      );

      if (response.statusCode == 200) {
        return response.data.toString();
      }

      throw Exception('Payment verification failed');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Please login again');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
