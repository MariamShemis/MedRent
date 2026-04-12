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
    const String baseUrl = 'http://GraduationProject.somee.com/';
    String imagePath = json['imageUrl'] ?? "";
    String finalImageUrl = "";
    if (imagePath.isNotEmpty) {
      if (imagePath.startsWith('http')) {
        finalImageUrl = imagePath;
      } else {
        String cleanPath = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
        finalImageUrl = '$baseUrl$cleanPath';
      }
    }

    return ProfileModel(
      userId: json['userId'] ?? 0,
      name: json['name'] ?? "",
      dateOfBirth: json['dateOfBirth'] ?? "",
      gender: json['gender'] ?? "",
      phone: json['phone'] ?? "",
      email: json['email'] ?? "",
      imageUrl: finalImageUrl,
    );
  }
}