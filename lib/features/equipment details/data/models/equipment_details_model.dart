class EquipmentDetailsModel {
  final int equipmentId;
  final String name;
  final String description;
  final bool availability;
  final double pricePerDay;
  final String imageUrl;

  EquipmentDetailsModel({
    required this.equipmentId,
    required this.name,
    required this.description,
    required this.availability,
    required this.pricePerDay,
    required this.imageUrl,
  });

  factory EquipmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return EquipmentDetailsModel(
      equipmentId: json['equipmentId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      availability: json['availability'] ?? false,
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      imageUrl: _formatImageUrl(json['imageUrl']),
    );
  }

  static String _formatImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return '';
    }
    String formattedUrl = imageUrl.replaceAll('\\', '/');
    return "http://graduationprojectapi.somee.com$formattedUrl";
  }
}