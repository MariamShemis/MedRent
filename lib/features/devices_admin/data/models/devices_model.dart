class DevicesModel {
  final int equipmentId;
  final String name;
  final String description;
  final int pricePerDay;
  final String imageUrl;
  final String ownerName;
  final String status;
  final int totalRentals;
  final int totalRevenue;

  DevicesModel({
    required this.equipmentId,
    required this.name,
    required this.description,
    required this.pricePerDay,
    required this.imageUrl,
    required this.ownerName,
    required this.status,
    required this.totalRentals,
    required this.totalRevenue,
  });

  factory DevicesModel.fromJson(Map<String, dynamic> json) {
    return DevicesModel(
      equipmentId: (json['equipmentId'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pricePerDay: (json['pricePerDay'] as num?)?.toInt() ?? 0, 
      imageUrl: json['imageUrl'] ?? '',
      ownerName: json['ownerName'] ?? 'Unknown',
      status: json['status'] ?? 'None',
      totalRentals: (json['totalRentals'] as num?)?.toInt() ?? 0,
      totalRevenue: (json['totalRevenue'] as num?)?.toInt() ?? 0,
    );
  }
}