class RentalSummaryResponse {
  final String equipmentName;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final int rentalDays;
  final double pricePerDay;
  final double rentalFee;
  final double insuranceFee;
  final double tax;
  final double totalPrice;

  const RentalSummaryResponse({
    required this.equipmentName,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.rentalDays,
    required this.pricePerDay,
    required this.rentalFee,
    required this.insuranceFee,
    required this.tax,
    required this.totalPrice,
  });

  factory RentalSummaryResponse.fromJson(Map<String, dynamic> json) {
    return RentalSummaryResponse(
      equipmentName: json['equipmentName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      rentalDays: json['rentalDays'] ?? 0,
      pricePerDay: (json['pricePerDay'] as num?)?.toDouble() ?? 0.0,
      rentalFee: (json['rentalFee'] as num?)?.toDouble() ?? 0.0,
      insuranceFee: (json['insuranceFee'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
