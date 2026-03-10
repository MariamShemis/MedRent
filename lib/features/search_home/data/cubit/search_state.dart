part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<HospitalModel> hospitals;
  final List<EquipmentModel> equipments;

  SearchSuccess({
    required this.hospitals,
    required this.equipments,
  });
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}