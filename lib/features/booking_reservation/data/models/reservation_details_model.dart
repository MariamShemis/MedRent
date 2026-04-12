class ReservationDetailsModel {
  final int id;
  final String name;
  final String phone;
  final String startDate;
  final String endDate;
  final String time;
  final String status;
  final String? type;
  final String? email;
  final String? notes;
  final double? price;
  final String? deviceName;

  ReservationDetailsModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.startDate,
    required this.endDate,
    required this.time,
    required this.status,
    this.type,
    this.email,
    this.notes,
    this.price,
    this.deviceName,
  });

  factory ReservationDetailsModel.fromJson(Map<String, dynamic> json) {
    return ReservationDetailsModel(
      id: json['rentalId'] ?? 0,
      name: json['customer'] ?? json['customerName'] ?? json['patientName'] ?? "Unknown",
      phone: json['phone'] ?? json['customerPhone'] ?? json['patientPhone'] ?? "",
      type: json['type'] ?? '',
      email: json['patientEmail'] ?? '',
      startDate: json['startDate'] ?? "",
      endDate: json['endDate'] ?? json['date'] ?? "",
      time: json['time'] ?? "",
      status: json['status'] ?? "",
      price: (json['totalPrice'] ?? json['price'])?.toDouble(),
      deviceName: json['device'] ?? json['deviceName'],
      notes: json['notes'],
    );
  }
}