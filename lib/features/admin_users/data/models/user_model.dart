class UserModel {
  final int userId;
  final String name;
  final String email;
  final String role;
  final int totalBookings;
  final String status;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.totalBookings,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      totalBookings: json['totalBookings'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'totalBookings': totalBookings,
      'status': status,
    };
  }
}