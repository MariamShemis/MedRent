class ProfileModel {
  final int userId;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String phone;
  final String email;
  final String imageUrl;

  ProfileModel({
    required this.userId,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.email,
    required this.imageUrl,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['userId'] ??0,
      name: json['name']??"",
      dateOfBirth: json['dateOfBirth']??"",
      gender: json['gender']??"",
      phone: json['phone']??"",
      email: json['email']??"",
      imageUrl: json['imageUrl']??"",
    );
  }
}
