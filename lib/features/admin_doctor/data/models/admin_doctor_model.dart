class AdminDoctorModel {
  final int doctorId;
  final String name;
  final String specialization;
  final int experienceYears;
  final double rating;
  final String startTime;
  final String endTime;
  final double consultationPrice;
  final String imageURL;
  final String department;
  final String hospital;

  AdminDoctorModel({
    required this.doctorId,
    required this.name,
    required this.specialization,
    required this.experienceYears,
    required this.rating,
    required this.startTime,
    required this.endTime,
    required this.consultationPrice,
    required this.imageURL,
    required this.department,
    required this.hospital,
  });

  factory AdminDoctorModel.fromJson(Map<String, dynamic> json) {
    return AdminDoctorModel(
      doctorId: json['doctorId'] ?? 0,
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      consultationPrice: (json['consultationPrice'] ?? 0.0).toDouble(),
      imageURL: json['imageURL'] ?? '',
      department: json['department'] ?? '',
      hospital: json['hospital'] ?? '',
    );
  }
}