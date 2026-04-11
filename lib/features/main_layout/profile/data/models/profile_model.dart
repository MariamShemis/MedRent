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
    const baseUrl = 'http://GraduationProject.somee.com';
    String imagePath = json['imageUrl'] ?? "";
    if (imagePath.isNotEmpty && !imagePath.startsWith('http')) {
      if (imagePath.startsWith('/')) {
        imagePath = imagePath.substring(1);
      }
      imagePath = '$baseUrl$imagePath';
    }
    return ProfileModel(
      userId: json['userId'] ?? 0,
      name: json['name'] ?? "",
      dateOfBirth: json['dateOfBirth'] ?? "",
      gender: json['gender'] ?? "",
      phone: json['phone'] ?? "",
      email: json['email'] ?? "",
      imageUrl: imagePath,
    );
  }
}