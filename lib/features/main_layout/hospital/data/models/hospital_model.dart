class HospitalModel {
  final int id;
  final String name;
  final String address;
  final double average;
  final int count;
  final double? reservationPrice;
  final String? imageUrl;
  final String? description;
  final List<String> departments;
  final List<String> equipments;
  final String? direction;

  HospitalModel({
    required this.id,
    required this.name,
    required this.address,
    required this.average,
    required this.count,
    this.reservationPrice,
    this.imageUrl,
    this.description,
    required this.departments,
    required this.equipments,
    this.direction,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      average: (json['average'] as num).toDouble(),
      count: json['count'],
      reservationPrice: json['reservationPrice'] != null
          ? (json['reservationPrice'] as num).toDouble()
          : null,
      imageUrl: json['imageUrl'] != null
          ? "http://GraduationProject.somee.com${json['imageUrl']}"
          .replaceAll("\\", "/")
          : null,
      description: json['description'],
      departments: json['departments'] != null
          ? List<String>.from(json['departments'])
          : [],
      equipments: json['equipments'] != null
          ? List<String>.from(json['equipments'])
          : [],
      direction: json['direction'],
    );
  }
}
