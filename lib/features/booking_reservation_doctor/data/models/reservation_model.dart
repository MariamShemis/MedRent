class ReservationModel {
  final int id;
  final String customerName;
  final String phone;
  final String date;
  final String time;
  final String status;
  final String? type;
  final String? itemName;
  final int? amount;

  ReservationModel({
    required this.id,
    required this.customerName,
    required this.phone,
    required this.date,
    required this.time,
    required this.status,
    this.type,
    this.itemName,
    this.amount,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['rentalId'] ?? json['bookingId'] ?? json['id'],
      customerName: json['customerName'] ?? json['patientName'] ?? "Unknown",
      phone: json['customerPhone'] ?? json['patientPhone'] ?? "",
      date: json['date'] ?? "",
      time: json['time'] ?? "",
      status: json['status'] ?? "",
      type: json['type'],
      itemName: json['deviceName'] ?? json['itemName'],
      amount: json['amount'] != null ? (json['amount'] as num).toInt() : null,
    );
  }
}
