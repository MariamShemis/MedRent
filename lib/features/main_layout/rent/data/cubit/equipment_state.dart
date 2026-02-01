part of 'equipment_cubit.dart';

@immutable
sealed class EquipmentState {}

final class EquipmentInitial extends EquipmentState {}
final class EquipmentLoading extends EquipmentState {}
class EquipmentLoaded extends EquipmentState {
  final List<EquipmentModel> equipments;
  EquipmentLoaded(this.equipments);
}

class EquipmentError extends EquipmentState {
  final String message;
  EquipmentError(this.message);
}
