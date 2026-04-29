class BookingSummaryResponse {
  final int bookingId;
  final String doctorName;
  final String departmentName;
  final String hospitalName;
  final String date;
  final String time;
  final double price;

  const BookingSummaryResponse({
    required this.bookingId,
    required this.doctorName,
    required this.departmentName,
    required this.hospitalName,
    required this.date,
    required this.time,
    required this.price,
  });

  factory BookingSummaryResponse.fromJson(Map<String, dynamic> json) {
    return BookingSummaryResponse(
      bookingId: json['bookingId'] ?? 0,
      doctorName: json['doctorName'] ?? '',
      departmentName: json['departmentName'] ?? '',
      hospitalName: json['hospitalName'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
