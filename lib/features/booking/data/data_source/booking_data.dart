import 'dart:io';
import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/network/network_checker.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/booking/data/model/booking_model.dart';

class BookingData {
  final ApiClient _apiClient;

  BookingData({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Options> _getAuthOptions() async {
    final token = await SessionService.getAuthToken();
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return Options(headers: headers);
  }

  /// POST /api/Booking → returns bookingId
  Future<int> createBooking({
    required int doctorId,
    required String date,
    required String time,
    String notes = ' ',
  }) async {
    try {
      final hasInternet = await NetworkChecker.hasInternetConnection();
      if (!hasInternet) {
        throw Exception('No Internet');
      }

      final options = await _getAuthOptions();
      final response = await _apiClient.post(
        '/Booking',
        data: {
          'doctorId': doctorId,
          'date': date,
          'time': time,
          'notes': notes,
        },
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['bookingId'] ?? 0;
      }

      throw Exception('Failed to create booking');
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

  Future<HospitalModel> getHospitalBookingDetails(int hospitalId) async {
    try {
      final hasInternet = await NetworkChecker.hasInternetConnection();

      if (!hasInternet) {
        throw Exception('No Internet');
      }

      final response = await _apiClient.get(
        '/Hospital/$hospitalId/booking-details',
      );

      if (response.statusCode == 200) {
        return HospitalModel.fromJson(response.data);
      }

      throw Exception('Failed to load hospital booking details');
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

  Future<List<AvailableTimeModel>> getDoctorAvailableTimes({
    required int doctorId,
    required DateTime date,
  }) async {
    try {
      final hasInternet = await NetworkChecker.hasInternetConnection();

      if (!hasInternet) {
        throw Exception('No Internet');
      }

      final formattedDate = '${date.month}/${date.day}/${date.year}';

      final response = await _apiClient.get(
        '/Hospital/doctor/$doctorId/available-times',
        queryParameters: {
          "date": formattedDate,
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        return AvailableTimeModel.fromJsonList(data);
      }

      throw Exception('Failed to load available times');
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
}