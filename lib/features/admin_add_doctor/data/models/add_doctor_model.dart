class AddDoctorModel {
  final String name;
  final String email;
  final String password;
  final String specialization;
  final int experienceYears;
  final double consultationPrice;
  final String startTime;
  final String endTime;
  final int departmentId;
  final String image;

  AddDoctorModel({
    required this.name,
    required this.email,
    required this.password,
    required this.specialization,
    required this.experienceYears,
    required this.consultationPrice,
    required this.startTime,
    required this.endTime,
    required this.departmentId,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Email': email,
      'Password': password,
      'Specialization': specialization,
      'ExperienceYears': experienceYears,
      'ConsultationPrice': consultationPrice,
      'StartTime': startTime,
      'EndTime': endTime,
      'DepartmentId': departmentId,
      'Image': image,
    };
  }
}