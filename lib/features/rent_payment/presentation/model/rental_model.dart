class RentalModel {
  final String equipmentName;
  final String equipmentDescription;
  final String equipmentImage;
  final String startDate; 
  final String endDate;
  final double rentalFee;
  final double insuranceFee;
  final double taxesAndFees;

  RentalModel({
    required this.equipmentName,
    required this.equipmentDescription,
    required this.equipmentImage,
    required this.startDate,
    required this.endDate,
    required this.rentalFee,
    required this.insuranceFee,
    required this.taxesAndFees,
  });

  double get totalCost => rentalFee + insuranceFee + taxesAndFees;
}
