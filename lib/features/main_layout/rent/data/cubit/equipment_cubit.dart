import 'package:bloc/bloc.dart';
import 'package:med_rent/features/equipment%20details/data/models/rating_summary.dart';
import 'package:med_rent/features/main_layout/rent/data/data_sources/equipment_data_source.dart';
import 'package:med_rent/features/main_layout/rent/data/models/equipment_model.dart';
import 'package:meta/meta.dart';

part 'equipment_state.dart';

class EquipmentCubit extends Cubit<EquipmentState> {
  final EquipmentDataSource dataSource;
  double currentMinPrice = 0;
  double currentMaxPrice = 2000;
  bool currentAvailable = false;

  EquipmentCubit(this.dataSource) : super(EquipmentInitial());

  Future<Map<int, RatingSummaryModel>> _fetchRatingSummaries(List<EquipmentModel> equipments) async {
    final Map<int, RatingSummaryModel> ratingSummaries = {};

    await Future.wait(
        equipments.map((equipment) async {
          try {
            final ratingSummary = await dataSource.getRatingSummary(equipment.equipmentId);
            ratingSummaries[equipment.equipmentId] = ratingSummary;
          } catch (e) {
            ratingSummaries[equipment.equipmentId] = RatingSummaryModel(
              average: equipment.rating,
              count: equipment.reviewsCount,
            );
          }
        })
    );

    return ratingSummaries;
  }

  void getAll() async {
    emit(EquipmentLoading());
    try {
      final data = await dataSource.search('');
      final ratingSummaries = await _fetchRatingSummaries(data);
      emit(EquipmentLoaded(
        equipments: data,
        ratingSummaries: ratingSummaries,
      ));
    } catch (e) {
      emit(EquipmentError(e.toString()));
    }
  }

  void search(String name) async {
    emit(EquipmentLoading());
    try {
      final data = await dataSource.search(name);
      final ratingSummaries = await _fetchRatingSummaries(data);
      emit(EquipmentLoaded(
        equipments: data,
        ratingSummaries: ratingSummaries,
      ));
    } catch (e) {
      emit(EquipmentError(e.toString()));
    }
  }

  void filter({double? min, double? max, bool? available}) async {
    if (min != null) currentMinPrice = min;
    if (max != null) currentMaxPrice = max;
    if (available != null) currentAvailable = available;

    emit(EquipmentLoading());
    try {
      final data = await dataSource.filter(
        minPrice: currentMinPrice,
        maxPrice: currentMaxPrice,
        available: currentAvailable,
      );
      final ratingSummaries = await _fetchRatingSummaries(data);
      emit(EquipmentLoaded(
        equipments: data,
        ratingSummaries: ratingSummaries,
      ));
    } catch (e) {
      emit(EquipmentError(e.toString()));
    }
  }

  void resetFilters() {
    currentMinPrice = 0;
    currentMaxPrice = 2000;
    currentAvailable = false;

    emit(EquipmentInitial());
    getAll();
  }

  Future<void> refreshRatingSummary(int equipmentId) async {
    if (state is! EquipmentLoaded) return;

    final currentState = state as EquipmentLoaded;

    try {
      final ratingSummary = await dataSource.getRatingSummary(equipmentId);

      final updatedRatingSummaries = Map<int, RatingSummaryModel>.from(currentState.ratingSummaries);
      updatedRatingSummaries[equipmentId] = ratingSummary;

      emit(EquipmentLoaded(
        equipments: currentState.equipments,
        ratingSummaries: updatedRatingSummaries,
      ));
    } catch (e) {
      print('Failed to refresh rating summary: $e');
    }
  }
}