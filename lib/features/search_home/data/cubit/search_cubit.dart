import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';
import 'package:med_rent/features/main_layout/rent/data/models/equipment_model.dart';
import 'package:med_rent/features/search_home/data/data_sources/search_remote_data_source.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRemoteDataSource remote;

  SearchCubit(this.remote) : super(SearchInitial());

  List<HospitalModel> hospitals = [];
  List<EquipmentModel> equipments = [];

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      hospitals.clear();
      equipments.clear();
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final hospitalsFuture = remote.searchHospitals(query);
      final equipmentsFuture = remote.searchEquipment(query);

      hospitals = await hospitalsFuture;
      equipments = await equipmentsFuture;

      emit(SearchSuccess(hospitals: hospitals, equipments: equipments));
    } on DioException catch (e) {
      emit(SearchError(e.message ?? "Network error"));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void clearSearch() {
    hospitals.clear();
    equipments.clear();
    emit(SearchInitial());
  }
}
