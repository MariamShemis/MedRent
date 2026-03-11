import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/equipment details/data/models/rating_summary.dart';
import 'package:med_rent/features/main_layout/rent/data/models/equipment_model.dart';

class EquipmentDataSource {
  final ApiClient _apiClient;

  EquipmentDataSource({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<EquipmentModel>> search(String name) async {
    final response = await _apiClient.get(
      '/Equipment/search',
      queryParameters: name.isNotEmpty ? {'name': name} : null,
    );

    return (response.data as List)
        .map((e) => EquipmentModel.fromJson(e))
        .toList();
  }

  Future<List<EquipmentModel>> filter({
    required double minPrice,
    required double maxPrice,
    required bool available,
  }) async {
    final response = await _apiClient.get(
      '/Equipment/filter',
      queryParameters: {
        'minPrice': minPrice,
        'maxPrice': maxPrice,
        'available': available,
      },
    );

    return (response.data as List)
        .map((e) => EquipmentModel.fromJson(e))
        .toList();
  }

  Future<RatingSummaryModel> getRatingSummary(int equipmentId) async {
    try {
      final response = await _apiClient.get(
        '/Equipment/$equipmentId/rating-summary',
      );

      return RatingSummaryModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Failed to load rating summary ${e.response?.statusCode}',
        );
      } else {
        throw Exception('Failed to load rating summary ${e.message}');
      }
    }
  }

  Future<Map<int, RatingSummaryModel>> getRatingSummaries(
    List<int> equipmentIds,
  ) async {
    try {
      final response = await _apiClient.post(
        '/Equipment/rating-summaries',
        data: {'equipmentIds': equipmentIds},
      );

      final Map<int, RatingSummaryModel> result = {};

      if (response.data is Map) {
        (response.data as Map).forEach((key, value) {
          result[int.parse(key.toString())] = RatingSummaryModel.fromJson(
            value,
          );
        });
      }

      return result;
    } on DioException catch (e) {
      throw Exception('Failed to load rating summaries ${e.message}');
    }
  }
}
