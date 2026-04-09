class RentResponse {
  final int rentalId;
  final double totalPrice;

  const RentResponse({
    required this.rentalId,
    required this.totalPrice,
  });

  factory RentResponse.fromJson(Map<String, dynamic> json) {
    return RentResponse(
      rentalId: json['rentalId'] ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
