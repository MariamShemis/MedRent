class HospitalReviewModel {
  final int hospitalReviewId;
  final String userName;
  final int rating;
  final String comment;
  final DateTime createdAt;

  HospitalReviewModel({
    required this.hospitalReviewId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory HospitalReviewModel.fromJson(Map<String, dynamic> json) {
    return HospitalReviewModel(
      hospitalReviewId: json['hospitalReviewId'],
      userName: json['userName'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
