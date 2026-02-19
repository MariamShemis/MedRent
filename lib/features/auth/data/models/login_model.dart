
class LoginModel {
  final String token;
  final int userId;
  final String name;
  final String role;

  LoginModel({
    required this.token,
    required this.userId,
    required this.name,
    required this.role,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] ?? '',
      userId: json['userId'] ?? 0,
      name: json['name'] ?? '',
      role: json['role'] ?? '',
    );
  }
}