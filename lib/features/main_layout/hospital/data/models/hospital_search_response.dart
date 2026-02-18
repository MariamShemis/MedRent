import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';

class HospitalSearchResponse {
  final bool success;
  final List<HospitalModel> results;

  HospitalSearchResponse({
    required this.success,
    required this.results,
  });

  factory HospitalSearchResponse.fromJson(Map<String, dynamic> json) {
    return HospitalSearchResponse(
      success: json['success'],
      results: json['results'] != null
          ? List<HospitalModel>.from(
        json['results'].map((e) => HospitalModel.fromJson(e)),
      )
          : [],
    );
  }
}
