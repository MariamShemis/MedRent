class BookingCheckoutResponse {
  final String paymentIntentId;
  final String clientSecret;
  final String? paymentUrl;

  const BookingCheckoutResponse({
    required this.paymentIntentId,
    required this.clientSecret,
    this.paymentUrl,
  });

  factory BookingCheckoutResponse.fromJson(Map<String, dynamic> json) {
    return BookingCheckoutResponse(
      paymentIntentId: json['paymentIntentId'] ?? '',
      clientSecret: json['clientSecret'] ?? '',
      paymentUrl: json['paymentUrl'],
    );
  }
}
