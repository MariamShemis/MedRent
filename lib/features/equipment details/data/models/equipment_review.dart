class ReviewModel {
  final String? userName;
  final String comment;
  final double rating;
  final DateTime? createdAt;

  ReviewModel({
    this.userName,
    required this.comment,
    required this.rating,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userName: json['userName'] ?? 'Anonymous',
      comment: json['comment'] ?? '',
      rating: (json['rating'] as num).toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}