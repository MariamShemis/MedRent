import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:med_rent/features/equipment%20details/data/cubit/equipment_details_state.dart';
import 'package:med_rent/features/equipment%20details/data/data_sources/equipment_details_data_source.dart';
import 'package:med_rent/core/error/api_error_handler.dart';

class EquipmentDetailsCubit extends Cubit<EquipmentDetailsState> {
  final EquipmentDetailsDataSource _dataSource;
  final BuildContext context;

  EquipmentDetailsCubit({
    required EquipmentDetailsDataSource dataSource,
    required this.context,
  })  : _dataSource = dataSource,
        super(EquipmentDetailsInitial());

  Future<void> fetchEquipmentDetails(int equipmentId) async {
    emit(EquipmentDetailsLoading());

    try {
      final equipment = await _dataSource.getEquipmentById(equipmentId, context);
      final reviews = await _dataSource.getEquipmentReviews(equipmentId, context);
      final ratingSummary = await _dataSource.getRatingSummary(equipmentId, context);
      final availability = await _dataSource.getEquipmentAvailability(equipmentId, context);

      emit(EquipmentDetailsLoaded(
        equipment: equipment,
        reviews: reviews,
        ratingSummary: ratingSummary,
        availability: availability,
      ));
    } catch (e) {
      // استخدام ApiErrorHandler إذا كان الخطأ DioException أو Unknown
      String errorMessage = e.toString();
      emit(EquipmentDetailsError(errorMessage));
    }
  }

  Future<void> refreshEquipmentDetails(int equipmentId) async {
    await fetchEquipmentDetails(equipmentId);
  }
}
