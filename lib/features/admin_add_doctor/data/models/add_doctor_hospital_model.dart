class AddDoctorHospitalModel {
  final int hospitalId;
  final String name;

  AddDoctorHospitalModel({
    required this.hospitalId,
    required this.name,
  });

  factory AddDoctorHospitalModel.fromJson(Map<String, dynamic> json) {
    return AddDoctorHospitalModel(
      hospitalId: json['hospitalId'],
      name: json['name'],
    );
  }
}