import 'package:dio/dio.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_search_response.dart';

class HospitalRemoteDataSource {
  final Dio dio;

  HospitalRemoteDataSource(this.dio);

  Future<List<HospitalModel>> getAllHospitals() async {
    final response = await dio.post(
      "http://GraduationProject.somee.com/api/Hospital/search",
      data: {
        "text": "string",
      },
    );

    final data = HospitalSearchResponse.fromJson(response.data);
    return data.results;
  }

  Future<List<HospitalModel>> searchHospitals(String text) async {
    final response = await dio.post(
      "http://GraduationProject.somee.com/api/Hospital/search",
      data: {
        "text": text,
      },
    );

    final data = HospitalSearchResponse.fromJson(response.data);
    return data.results;
  }
}

