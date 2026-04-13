class BookingModel {
  final String doctorName;
  final String departmentName;
  final String hospitalName;
  final String date;
  final String time;
  final double price;

  BookingModel({
    required this.doctorName,
    required this.departmentName,
    required this.hospitalName,
    required this.date,
    required this.time,
    required this.price,
  });
}
