import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/hospital_details/data/models/hospital_review_model.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';

class HospitalDetailsDataSource {
  final ApiClient _apiClient;

  HospitalDetailsDataSource({required ApiClient apiClient})
    : _apiClient = apiClient;

  Future<HospitalModel> getHospitalDetails(int id) async {
    final response = await _apiClient.get('/Hospital/$id');

    return HospitalModel.fromJson(response.data);
  }

  Future<List<HospitalReviewModel>> getHospitalReviews(int id) async {
    final response = await _apiClient.get('/Hospital/$id/reviews');

    return (response.data as List)
        .map((json) => HospitalReviewModel.fromJson(json))
        .toList();
  }
}
