class Endpoints {
  static const String login = "/Auth/login";
  static const String register = "/Auth/register";
  static const String equipmentName = "/Equipment/search?name=VALUE";

  // Rent Payment
  static const String rentEquipment = "/Equipment/rent";
  static const String paymentSummary = "/Payment"; // /Payment/{rentalId}/summary
  static const String startCheckout = "/Payment/start-checkout";
  static const String verifyPayment = "/Payment/verify"; // /Payment/verify/{paymentIntentId}

  // Booking Payment
  static const String createBooking = "/Booking";
  static const String bookingSummary = "/Booking"; // /Booking/{bookingId}/summary
  static const String bookingCreateIntent = "/BookingPayment/create-intent"; // /BookingPayment/create-intent/{bookingId}
  static const String bookingVerifyPayment = "/BookingPayment/verify";
}

