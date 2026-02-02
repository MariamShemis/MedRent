import 'package:bloc/bloc.dart';
import 'package:med_rent/features/equipment%20details/data/cubit/equipment_details_state.dart';
import 'package:med_rent/features/equipment%20details/data/data_sources/equipment_details_data_source.dart';

class EquipmentDetailsCubit extends Cubit<EquipmentDetailsState> {
  final EquipmentDetailsDataSource _dataSource;

  EquipmentDetailsCubit({required EquipmentDetailsDataSource dataSource})
      : _dataSource = dataSource,
        super(EquipmentDetailsInitial());

  Future<void> fetchEquipmentDetails(int equipmentId) async {
    emit(EquipmentDetailsLoading());

    try {
      final equipment = await _dataSource.getEquipmentById(equipmentId);
      final reviews = await _dataSource.getEquipmentReviews(equipmentId);
      final ratingSummary = await _dataSource.getRatingSummary(equipmentId);
      final availability = await _dataSource.getEquipmentAvailability(equipmentId);

      emit(EquipmentDetailsLoaded(
        equipment: equipment,
        reviews: reviews,
        ratingSummary: ratingSummary,
        availability: availability,
      ));
    } catch (e) {
      emit(EquipmentDetailsError('Failed to load equipment details: $e'));
    }
  }

  Future<void> refreshEquipmentDetails(int equipmentId) async {
    await fetchEquipmentDetails(equipmentId);
  }
}