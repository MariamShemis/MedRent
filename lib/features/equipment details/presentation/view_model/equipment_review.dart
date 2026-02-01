class EquipmentReview {
  final int reviewId;
  final String userId;
  final String userName;
  final int rating;
  final String comment;
  final DateTime reviewDate;

  EquipmentReview({
    required this.reviewId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.reviewDate,
  });

  factory EquipmentReview.fromJson(Map<String, dynamic> json) {
    return EquipmentReview(
      reviewId: json['reviewId'],
      userId: json['userId'],
      userName: json['userName'],
      rating: json['rating'],
      comment: json['comment'],
      reviewDate: DateTime.parse(json['reviewDate']),
    );
  }
}