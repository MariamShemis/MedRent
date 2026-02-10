class RentalModel {
  final int rentalId;
  final int equipmentId;
  final String equipmentName;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final double totalPrice;
  final String status;

  const RentalModel({
    required this.rentalId,
    required this.equipmentId,
    required this.equipmentName,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
  });

  factory RentalModel.fromJson(Map<String, dynamic> json) {
    return RentalModel(
      rentalId: json['rentalId'] ?? 0,

      // ✅ اسم المفتاح مظبوط زي الـ API
      equipmentId: json['equipmentiId'] ?? 0,

      equipmentName: json['equipmentName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rentalId': rentalId,
      'equipmentiId': equipmentId,
      'equipmentName': equipmentName,
      'imageUrl': imageUrl,
      'startDate': startDate,
      'endDate': endDate,
      'totalPrice': totalPrice,
      'status': status,
    };
  }
}
