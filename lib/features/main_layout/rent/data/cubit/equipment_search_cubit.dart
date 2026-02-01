import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'equipment_search_state.dart';

class EquipmentSearchCubit extends Cubit<EquipmentSearchState> {
  EquipmentSearchCubit() : super(EquipmentSearchInitial());
}
