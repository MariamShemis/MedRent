import 'package:dio/dio.dart';
import 'package:med_rent/features/hospital_details/data/models/hospital_review_model.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';

class HospitalDetailsDataSource {
  final Dio _dio = Dio();

  Future<HospitalModel> getHospitalDetails(int id) async {
    final response = await _dio.get('http://GraduationProject.somee.com/api/Hospital/$id');
    return HospitalModel.fromJson(response.data);
  }

  Future<List<HospitalReviewModel>> getHospitalReviews(int id) async {
    final response = await _dio.get('http://GraduationProject.somee.com/api/Hospital/$id/reviews');
    return (response.data as List)
        .map((json) => HospitalReviewModel.fromJson(json))
        .toList();
  }
}
