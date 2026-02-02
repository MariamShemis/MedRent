part of 'equipment_cubit.dart';

@immutable
sealed class EquipmentState {}

final class EquipmentInitial extends EquipmentState {}

final class EquipmentLoading extends EquipmentState {}

class EquipmentLoaded extends EquipmentState {
  final List<EquipmentModel> equipments;
  final Map<int, RatingSummaryModel> ratingSummaries; // ✅ إضافة Map للـ rating summaries

  EquipmentLoaded({
    required this.equipments,
    this.ratingSummaries = const {}, // ✅ default empty map
  });
}

class EquipmentError extends EquipmentState {
  final String message;
  EquipmentError(this.message);
}