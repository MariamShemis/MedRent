import 'package:bloc/bloc.dart';
import 'package:med_rent/features/hospital_details/data/cubit/hospital_details_state.dart';
import 'package:med_rent/features/hospital_details/data/data_sources/hospital_details_data_source.dart';

class HospitalDetailsCubit extends Cubit<HospitalDetailsState> {
  final HospitalDetailsDataSource _dataSource;

  HospitalDetailsCubit(this._dataSource) : super(HospitalDetailsInitial());

  Future<void> fetchHospitalDetails(int id) async {
    emit(HospitalDetailsLoading());
    try {
      final hospital = await _dataSource.getHospitalDetails(id);
      final reviews = await _dataSource.getHospitalReviews(id);
      emit(HospitalDetailsLoaded(hospital: hospital, reviews: reviews));
    } catch (e) {
      emit(HospitalDetailsError(e.toString()));
    }
  }
}
