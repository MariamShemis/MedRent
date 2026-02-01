import 'package:bloc/bloc.dart';
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

  void getAll() async {
    emit(EquipmentLoading());
    try {
      final data = await dataSource.search('');
      emit(EquipmentLoaded(data));
    } catch (e) {
      emit(EquipmentError(e.toString()));
    }
  }

  void search(String name) async {
    emit(EquipmentLoading());
    try {
      final data = await dataSource.search(name);
      emit(EquipmentLoaded(data));
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
      emit(EquipmentLoaded(data));
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
}
