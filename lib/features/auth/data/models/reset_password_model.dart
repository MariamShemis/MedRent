class ResetPasswordModel {
  final String message;
  ResetPasswordModel({required this.message});
  factory ResetPasswordModel.fromjson(Map<String, dynamic> json) {
    return ResetPasswordModel(message: json['message'] ?? 'Sucess');
  }
}
