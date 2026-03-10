import 'package:dio/dio.dart';
import 'package:med_rent/features/equipment%20details/data/models/rating_summary.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_search_response.dart';
import 'package:med_rent/features/main_layout/rent/data/models/equipment_model.dart';

class SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSource(this.dio);

  Future<List<HospitalModel>> searchHospitals(String text) async {
    final response = await dio.post(
      "http://GraduationProject.somee.com/api/Hospital/search",
      data: {"text": text},
    );

    final model = HospitalSearchResponse.fromJson(response.data);

    return model.results;
  }

  Future<List<EquipmentModel>> searchEquipment(String name) async {
    final response = await dio.get(
      "http://GraduationProject.somee.com/api/Equipment/search",
      queryParameters: {"name": name},
    );

    final List data = response.data;

    List<EquipmentModel> equipments = data
        .map((e) => EquipmentModel.fromJson(e))
        .toList();

    for (int i = 0; i < equipments.length; i++) {
      final rating = await getEquipmentRating(equipments[i].equipmentId);

      equipments[i] = EquipmentModel(
        equipmentId: equipments[i].equipmentId,
        name: equipments[i].name,
        description: equipments[i].description,
        availability: equipments[i].availability,
        pricePerDay: equipments[i].pricePerDay,
        imageUrl: equipments[i].imageUrl,
        ratingSummary: rating,
      );
    }

    return equipments;
  }

  Future<RatingSummaryModel> getEquipmentRating(int id) async {
    final response = await dio.get(
      "http://GraduationProject.somee.com/api/Equipment/$id/rating-summary",
    );

    return RatingSummaryModel.fromJson(response.data);
  }
}
