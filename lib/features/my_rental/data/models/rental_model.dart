class RentalModel {
  final int rentalId;
  final String equipmentName;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final double totalPrice;
  final String status;

  const RentalModel({
    required this.rentalId,
    required this.equipmentName,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
  });

  factory RentalModel.fromJson(Map<String, dynamic> json) {
    return RentalModel(
      rentalId: json['rentalId'],
      equipmentName: json['equipmentName'],
      imageUrl: json['imageUrl'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      totalPrice: (json['totalPrice']).toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rentalId': rentalId,
      'equipmentName': equipmentName,
      'imageUrl': imageUrl,
      'startDate': startDate,
      'endDate': endDate,
      'totalPrice': totalPrice,
      'status': status,
    };
  }
}