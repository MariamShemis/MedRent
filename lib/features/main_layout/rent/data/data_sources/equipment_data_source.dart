import 'package:dio/dio.dart';
import 'package:med_rent/features/main_layout/rent/data/models/equipment_model.dart';

class EquipmentDataSource {
  final Dio dio;
  EquipmentDataSource(this.dio);

  Future<List<EquipmentModel>> search(String name) async {
    final response = await dio.get(
      'http://graduationprojectapi.somee.com/api/Equipment/search',
queryParameters: name.isNotEmpty ? {'name': name} : null,    );
    return (response.data as List)
        .map((e) => EquipmentModel.fromJson(e))
        .toList();
  }

  Future<List<EquipmentModel>> filter({
    required double minPrice,
    required double maxPrice,
    required bool available,
  }) async {
    final response = await dio.get(
      'http://graduationprojectapi.somee.com/api/Equipment/filter',
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
}