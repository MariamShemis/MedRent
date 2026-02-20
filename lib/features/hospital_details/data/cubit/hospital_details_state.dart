import 'package:med_rent/features/hospital_details/data/models/hospital_review_model.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';

abstract class HospitalDetailsState {}

class HospitalDetailsInitial extends HospitalDetailsState {}

class HospitalDetailsLoading extends HospitalDetailsState {}

class HospitalDetailsLoaded extends HospitalDetailsState {
  final HospitalModel hospital;
  final List<HospitalReviewModel> reviews;

  HospitalDetailsLoaded({
    required this.hospital,
    required this.reviews,
  });
}

class HospitalDetailsError extends HospitalDetailsState {
  final String message;

  HospitalDetailsError(this.message);
}
