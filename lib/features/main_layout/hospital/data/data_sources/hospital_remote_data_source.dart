import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_search_response.dart';

class HospitalRemoteDataSource {
  final ApiClient _apiClient;

  HospitalRemoteDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<List<HospitalModel>> getAllHospitals() async {
    final response = await _apiClient.post(
      '/Hospital/search',
      data: {
        "text": "string",
      },
    );

    final data = HospitalSearchResponse.fromJson(response.data);

    return data.results;
  }

  Future<List<HospitalModel>> searchHospitals(String text) async {
    final response = await _apiClient.post(
      '/Hospital/search',
      data: {
        "text": text,
      },
    );

    final data = HospitalSearchResponse.fromJson(response.data);

    return data.results;
  }
}