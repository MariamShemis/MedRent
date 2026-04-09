class NotificationSettingsModel {
  final int id;
  final int userId;
  bool appointmentReminders;
  bool equipmentRentalAlerts;

  NotificationSettingsModel({
    required this.id,
    required this.userId,
    required this.appointmentReminders,
    required this.equipmentRentalAlerts,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      appointmentReminders: json['appointmentReminders'] ?? false,
      equipmentRentalAlerts: json['equipmentRentalAlerts'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "appointmentReminders": appointmentReminders,
      "equipmentRentalAlerts": equipmentRentalAlerts,
    };
  }
}