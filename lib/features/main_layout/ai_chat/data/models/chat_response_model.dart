class ChatResponseModel {
  final String department;
  final List<String> suggestedActions;
  final String howToUse;
  final List<HospitalModel> hospitals;

  ChatResponseModel({
    required this.department,
    required this.suggestedActions,
    required this.howToUse,
    required this.hospitals,
  });

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      department: json['department'] ?? "General Medicine",
      suggestedActions: List<String>.from(json['suggestedActions'] ?? []),
      howToUse: json['howToUse'] ?? "Consult a specialist for more details.",
      hospitals: (json['hospitals'] as List?)
              ?.map((i) => HospitalModel.fromJson(i))
              .toList() ?? [],
    );
  }
}

class HospitalModel {
  final int? hospitalId;
  final String name;
  final double rating;
  final double? distance;

  HospitalModel({required this.name, required this.rating, this.distance, this.hospitalId});

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      name: json['name'] ?? "Unknown Hospital",
      rating: (json['rating'] ?? 0).toDouble(),
      hospitalId: (json['hospitalId'] ?? 0),
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
