class OwnerDevicesModel {
  final int equipmentId;
  final String name;
  final String description;
  final double pricePerDay;
  final String status;
  final double rating;

  OwnerDevicesModel({
    required this.equipmentId,
    required this.name,
    required this.description,
    required this.pricePerDay,
    required this.status,
    required this.rating,
  });
  factory OwnerDevicesModel.fromJson(Map<String, dynamic> json) {
    return OwnerDevicesModel(
      equipmentId: (json['equipmentId'] as num?)?.toInt() ?? 0,
      name: json['name'] ??"",
      description: json['description'] ?? "",
      pricePerDay: (json['pricePerDay'] as num?)?.toDouble() ?? 0,
      status: json['status'] ?? "None",
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
    );
  }
}
