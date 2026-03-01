class ChatResponseModel {
  final String? department;
  final List<String> ?suggestedActions;
  final String ?howToUse;
  final List<HospitalModel>? hospitals;

  ChatResponseModel({this.department, required this.suggestedActions,  required this.howToUse, this.hospitals});

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
  return ChatResponseModel(
    department: json['department']?? "General",
    suggestedActions: json['suggestedActions'] != null 
        ? List<String>.from(json['suggestedActions']) 
        : [],
    hospitals: json['hospitals'] != null 
        ? (json['hospitals'] as List).map((i) => HospitalModel.fromJson(i)).toList() 
        : null, 
    howToUse: json['howToUse'] ?? "Please follow the instructions provided by the AI.",
  );
}
}

class HospitalModel {
  final String name;
  final double rating;
  final double? distance;

  HospitalModel({required this.name, required this.rating, this.distance});

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      name: json['name'] ?? "Unknown Hospital",
      rating: (json['rating'] ?? 0).toDouble(),
      distance: (json['distanceKm'] ?? 0).toDouble(),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final ChatResponseModel? fullResponse;
  ChatMessage({required this.isUser, required this.text, this.fullResponse});
}
