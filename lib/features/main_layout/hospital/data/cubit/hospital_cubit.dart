import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/main_layout/hospital/data/cubit/hospital_state.dart';
import 'package:med_rent/features/main_layout/hospital/data/data_sources/hospital_remote_data_source.dart';
import 'package:med_rent/features/main_layout/hospital/data/models/hospital_model.dart';

class HospitalCubit extends Cubit<HospitalState> {
  final HospitalRemoteDataSource remoteDataSource;

  HospitalCubit(this.remoteDataSource) : super(HospitalInitial());

  Future<void> getAllHospitals() async {
    emit(HospitalLoading());
    try {
      final result = await remoteDataSource.getAllHospitals();
      emit(HospitalLoaded(result));
    } catch (e) {
      emit(HospitalError(e.toString()));
    }
  }

  Future<void> searchOrGetAll(String text) async {
    emit(HospitalLoading());
    try {
      List<HospitalModel> result;
      if (text.isEmpty) {
        result = await remoteDataSource.getAllHospitals();
      } else {
        result = await remoteDataSource.searchHospitals(text);
      }
      if (text.isNotEmpty && result.isEmpty) {
        emit(HospitalError("No hospitals found"));
      } else {
        emit(HospitalLoaded(result));
      }
    } catch (e) {
      emit(HospitalError(e.toString()));
    }
  }
}
