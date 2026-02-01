class EquipmentDetailsModel {
  final int equipmentId;
  final String name;
  final String description;
  final bool availability;
  final double pricePerDay;
  final String imageUrl;

  EquipmentDetailsModel({
    required this.equipmentId,
    required this.name,
    required this.description,
    required this.availability,
    required this.pricePerDay,
    required this.imageUrl,
  });

  factory EquipmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return EquipmentDetailsModel(
      equipmentId: json['equipmentId'],
      name: json['name'],
      description: json['description'],
      availability: json['availability'],
      pricePerDay: json['pricePerDay'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}