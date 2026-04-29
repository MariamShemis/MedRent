class AddDoctorDepartmentModel {
  final int departmentId;
  final String name;

  AddDoctorDepartmentModel({
    required this.departmentId,
    required this.name,
  });

  factory AddDoctorDepartmentModel.fromJson(Map<String, dynamic> json) {
    return AddDoctorDepartmentModel(
      departmentId: json['departmentId'],
      name: json['name'],
    );
  }
}