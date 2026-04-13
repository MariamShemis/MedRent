import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import '../models/booking_summary_response.dart';
import '../models/booking_checkout_response.dart';

class BookingPaymentDataSource {
  final ApiClient _apiClient;

  BookingPaymentDataSource({required ApiClient apiClient})
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

  /// GET /Booking/{bookingId}/summary
  Future<BookingSummaryResponse> getBookingSummary(int bookingId) async {
    try {
      final options = await _getOptions();

      final response = await _apiClient.get(
        '/Booking/$bookingId/summary',
        options: options,
      );

      if (response.statusCode == 200) {
        return BookingSummaryResponse.fromJson(response.data);
      }

      throw Exception('Failed to load booking summary');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Please login again');
      }
      if (e.response?.data != null && e.response?.data is Map) {
        final message = e.response?.data['message'];
        if (message != null) {
          throw Exception(message.toString());
        }
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// POST /BookingPayment/create-intent/{bookingId}
  Future<BookingCheckoutResponse> createPaymentIntent(int bookingId) async {
    try {
      final options = await _getOptions();

      final response = await _apiClient.post(
        '/BookingPayment/create-intent/$bookingId',
        data: {},
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return BookingCheckoutResponse.fromJson(response.data);
      }
      throw Exception('Failed to create payment intent');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Please login again');
      }
      if (e.response?.data != null && e.response?.data is Map) {
        final message = e.response?.data['message'];
        if (message != null) {
          throw Exception(message.toString());
        }
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// POST /BookingPayment/verify
  Future<String> verifyPayment({
    required String paymentIntentId,
    required String patientName,
    required String patientEmail,
    required String patientPhone,
    required String bookingType,
  }) async {
    try {
      final options = await _getOptions();

      final response = await _apiClient.post(
        '/BookingPayment/verify',
        data: {
          'paymentIntentId': paymentIntentId,
          'patientName': patientName,
          'patientEmail': patientEmail,
          'patientPhone': patientPhone,
          'bookingType': bookingType,
        },
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
      if (e.response?.data != null && e.response?.data is Map) {
        final message = e.response?.data['message'];
        if (message != null) {
          throw Exception(message.toString());
        }
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error verifying payment: $e');
    }
  }
}
