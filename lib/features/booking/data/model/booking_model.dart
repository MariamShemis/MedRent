// lib/features/booking/data/booking_model.dart

class HospitalModel {
  final int hospitalId;
  final String hospitalName;
  final List<DepartmentModel> departments;

  HospitalModel({
    required this.hospitalId,
    required this.hospitalName,
    required this.departments,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      hospitalId: json['hospitalId'] ?? 0,
      hospitalName: json['hospitalName'] ?? '',
      departments: (json['departments'] as List? ?? [])
          .map((dept) => DepartmentModel.fromJson(dept))
          .toList(),
    );
  }
}

class DepartmentModel {
  final int departmentId;
  final String name;
  final List<DoctorModel> doctors;

  DepartmentModel({
    required this.departmentId,
    required this.name,
    required this.doctors,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      departmentId: json['departmentId'] ?? 0,
      name: json['name'] ?? '',
      doctors: (json['doctors'] as List? ?? [])
          .map((doctor) => DoctorModel.fromJson(doctor))
          .toList(),
    );
  }
}

class DoctorModel {
  final int doctorId;
  final String name;
  final String specialization;
  final int experienceYears;

  DoctorModel({
    required this.doctorId,
    required this.name,
    required this.specialization,
    required this.experienceYears,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorId: json['doctorId'] ?? 0,
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
    );
  }
}

class AvailableTimeModel {
  final String time;

  AvailableTimeModel({required this.time});

  factory AvailableTimeModel.fromJson(String time) {
    return AvailableTimeModel(time: time);
  }

  static List<AvailableTimeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((time) => AvailableTimeModel.fromJson(time)).toList();
  }
}