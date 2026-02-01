class RatingSummary {
  final double average;
  final int count;

  RatingSummary({
    required this.average,
    required this.count,
  });

  factory RatingSummary.fromJson(Map<String, dynamic> json) {
    return RatingSummary(
      average: json['average'].toDouble(),
      count: json['count'],
    );
  }
}
