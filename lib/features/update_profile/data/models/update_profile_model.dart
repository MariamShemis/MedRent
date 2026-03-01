class UpdateProfileRequest {
  final String name;
  final String dateOfBirth;
  final String gender;
  final String phone;
  final String email;

  UpdateProfileRequest({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "phone": phone,
      "email": email,
    };
  }
}

class UpdateProfileResponse {
  final String message;

  UpdateProfileResponse({required this.message});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      message: json['message'],
    );
  }
}

class UploadImageResponse {
  final String imageUrl;

  UploadImageResponse({required this.imageUrl});

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) {
    return UploadImageResponse(
      imageUrl: json['imageUrl'],
    );
  }
}