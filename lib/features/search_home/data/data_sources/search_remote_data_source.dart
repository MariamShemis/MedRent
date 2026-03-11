import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/equipment details/data/models/rating_summary.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_search_response.dart';
import 'package:med_rent/features/main_layout/rent/data/models/equipment_model.dart';

class SearchRemoteDataSource {
  final ApiClient _apiClient;

  SearchRemoteDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<List<HospitalModel>> searchHospitals(String text) async {
    final response = await _apiClient.post(
      '/Hospital/search',
      data: {"text": text},
    );

    final model = HospitalSearchResponse.fromJson(response.data);

    return model.results;
  }

  Future<List<EquipmentModel>> searchEquipment(String name) async {
    final response = await _apiClient.get(
      '/Equipment/search',
      queryParameters: {"name": name},
    );

    final List data = response.data;

    List<EquipmentModel> equipments = data
        .map((e) => EquipmentModel.fromJson(e))
        .toList();

    for (int i = 0; i < equipments.length; i++) {
      final rating = await getEquipmentRating(equipments[i].equipmentId);

      equipments[i] = equipments[i].copyWith(ratingSummary: rating);
    }

    return equipments;
  }

  Future<RatingSummaryModel> getEquipmentRating(int id) async {
    final response = await _apiClient.get(
      '/Equipment/$id/rating-summary',
    );

    return RatingSummaryModel.fromJson(response.data);
  }
}