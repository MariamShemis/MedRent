class Endpoints {
  static const String login = "/Auth/login";
  static const String register = "/Auth/register";
  static const String equipmentName = "/Equipment/search?name=VALUE";

  // Rent Payment
  static const String rentEquipment = "/Equipment/rent";
  static const String paymentSummary = "/Payment"; // /Payment/{rentalId}/summary
  static const String startCheckout = "/Payment/start-checkout";
  static const String verifyPayment = "/Payment/verify"; // /Payment/verify/{paymentIntentId}
}

