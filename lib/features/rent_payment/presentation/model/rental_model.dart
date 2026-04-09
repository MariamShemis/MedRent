class RentalModel {
  final String equipmentName;
  final String equipmentImage;
  final String startDate;
  final String endDate;
  final int rentalDays;
  final double pricePerDay;
  final double rentalFee;
  final double insuranceFee;
  final double taxesAndFees;

  RentalModel({
    required this.equipmentName,
    required this.equipmentImage,
    required this.startDate,
    required this.endDate,
    required this.rentalDays,
    required this.pricePerDay,
    required this.rentalFee,
    required this.insuranceFee,
    required this.taxesAndFees,
  });

  double get totalCost => rentalFee + insuranceFee + taxesAndFees;
}
