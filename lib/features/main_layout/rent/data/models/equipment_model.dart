import 'package:med_rent/features/equipment%20details/data/models/rating_summary.dart';

class EquipmentModel {
  final int equipmentId;
  final String name;
  final String description;
  final bool availability;
  final double pricePerDay;
  final String imageUrl;
  final RatingSummaryModel ratingSummary;

  EquipmentModel({
    required this.availability,
    required this.description,
    required this.equipmentId,
    required this.imageUrl,
    required this.name,
    required this.pricePerDay,
    required this.ratingSummary,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) {
    return EquipmentModel(
      availability: json['availability'] ?? false,
      description: json['description'] ?? '',
      equipmentId: json['equipmentId'] ?? 0,
      imageUrl: "http://graduationprojectapi.somee.com${json['imageUrl']?.toString().replaceAll('\\', '/')}",
      name: json['name'] ?? '',
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      ratingSummary: RatingSummaryModel.fromJson(json['ratingSummary'] ?? {}),
    );
  }

  double get rating => ratingSummary.average;
  int get reviewsCount => ratingSummary.count;
}