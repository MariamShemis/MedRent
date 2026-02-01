class EquipmentModel {
  final int equipmentId;
  final String name;
  final String description;
  final bool availability;
  final double pricePerDay;
  final String imageUrl;
   final double rating;
  final int reviewsCount;
  EquipmentModel({
    required this.availability,
    required this.description,
    required this.equipmentId,
    required this.imageUrl,
    required this.name,
    required this.pricePerDay,
    this.rating = 4,
    this.reviewsCount = 20,
  });
  factory EquipmentModel.fromJson(Map<String, dynamic> json) {
  return EquipmentModel(
    availability: json['availability'] ?? false,
    description: json['description'] ?? '',
    equipmentId: json['equipmentId'] ?? 0,
    imageUrl: "http://graduationprojectapi.somee.com${json['imageUrl']?.toString().replaceAll('\\', '/')}",
    name: json['name'] ?? '',
    pricePerDay: (json['pricePerDay'] as num).toDouble(),
  );
}
}
