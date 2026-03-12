import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import '../models/rental_model.dart';

class MyRentalDataSource {
  final ApiClient _apiClient;

  MyRentalDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<String?> _getToken() async {
    return await SessionService.getAuthToken();
  }

  Future<int?> _getUserId() async {
    return await SessionService.getUserId();
  }

  Future<Options> _getOptions() async {
    final token = await _getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return Options(headers: headers);
  }

  Future<List<RentalModel>> getUserRentals() async {
    try {
      final userId = await _getUserId();

      if (userId == null) {
        throw Exception('User not logged in');
      }

      final options = await _getOptions();

      final response = await _apiClient.get(
        '/Profile/$userId',
        options: options,
      );

      if (response.statusCode == 200) {
        final List data = response.data;

        return data.map((e) => RentalModel.fromJson(e)).toList();
      }

      throw Exception('Failed to load rentals');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Please login again');
      }

      throw Exception('Network error');
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  Future<List<RentalModel>> searchRentals(String query) async {
    try {
      final userId = await _getUserId();

      if (userId == null) {
        throw Exception('User not logged in');
      }

      final options = await _getOptions();

      final response = await _apiClient.get(
        '/Profile/search',
        options: options,
        queryParameters: {
          'userId': userId,
          'name': query,
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data;

        return data.map((e) => RentalModel.fromJson(e)).toList();
      }

      return [];
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Please login again');
      }

      return [];
    } catch (_) {
      return [];
    }
  }
}