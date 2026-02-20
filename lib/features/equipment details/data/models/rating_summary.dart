class RatingSummaryModel {
  final double average;
  final int count;
  final List<RatingDistribution>? distribution;

  RatingSummaryModel({
    required this.average,
    required this.count,
    this.distribution,
  });

  factory RatingSummaryModel.fromJson(Map<String, dynamic> json) {
    List<RatingDistribution>? distributionList;

    if (json['distribution'] != null && json['distribution'] is List) {
      distributionList = (json['distribution'] as List)
          .map((item) => RatingDistribution.fromJson(item))
          .toList();
    }

    return RatingSummaryModel(
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
      distribution: distributionList,
    );
  }
}

class RatingDistribution {
  final int rating;
  final int count;

  RatingDistribution({
    required this.rating,
    required this.count,
  });

  factory RatingDistribution.fromJson(Map<String, dynamic> json) {
    return RatingDistribution(
      rating: json['rating'] ?? 0,
      count: json['count'] ?? 0,
    );
  }
}