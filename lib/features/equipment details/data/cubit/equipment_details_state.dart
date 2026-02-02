import 'package:med_rent/features/equipment%20details/presentation/view_model/equipment_availability.dart';
import 'package:med_rent/features/equipment%20details/presentation/view_model/equipment_details_model.dart';
import 'package:med_rent/features/equipment%20details/presentation/view_model/equipment_review.dart';
import 'package:med_rent/features/equipment%20details/presentation/view_model/rating_summary.dart';

abstract class EquipmentDetailsState {}

class EquipmentDetailsInitial implements EquipmentDetailsState {}

class EquipmentDetailsLoading implements EquipmentDetailsState {}

class EquipmentDetailsLoaded implements EquipmentDetailsState {
  final EquipmentDetailsModel equipment;
  final List<ReviewModel> reviews;
  final RatingSummaryModel ratingSummary;
  final AvailabilityModel availability;

  EquipmentDetailsLoaded({
    required this.equipment,
    required this.reviews,
    required this.ratingSummary,
    required this.availability,
  });
}

class EquipmentDetailsError implements EquipmentDetailsState {
  final String message;

  EquipmentDetailsError(this.message);
}