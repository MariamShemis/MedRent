class CheckoutResponse {
  final String paymentIntentId;
  final String clientSecret;
  final String paymentUrl;

  const CheckoutResponse({
    required this.paymentIntentId,
    required this.clientSecret,
    required this.paymentUrl,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      paymentIntentId: json['paymentIntentId'] ?? '',
      clientSecret: json['clientSecret'] ?? '',
      paymentUrl: json['paymentUrl'] ?? '',
    );
  }
}
