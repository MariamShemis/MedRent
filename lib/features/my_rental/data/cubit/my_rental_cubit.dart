import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/my_rental/data/cubit/my_rental_state.dart';
import 'package:med_rent/features/my_rental/data/data_sources/my_rental_data_source.dart';
import 'package:med_rent/features/my_rental/data/models/rental_model.dart';

class MyRentalCubit extends Cubit<MyRentalState> {
  final MyRentalDataSource dataSource;

  final int itemsPerPage = 2;

  List<RentalModel> _allRentals = [];
  List<RentalModel> _filteredRentals = [];

  int _currentPage = 0;

  MyRentalCubit({required this.dataSource})
      : super(MyRentalInitial());

  Future<void> loadRentals() async {
    emit(MyRentalLoading());

    try {
      _allRentals = await dataSource.getUserRentals();
      _filteredRentals = _allRentals;
      _currentPage = 0;
      _emitState();
    } catch (e) {
      emit(MyRentalError(e.toString()));
    }
  }

  void searchRentals(String query) {
    _currentPage = 0;

    if (query.isEmpty) {
      _filteredRentals = _allRentals;
    } else {
      _filteredRentals = _allRentals.where((rental) {
        return rental.equipmentName
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }

    _emitState(searchQuery: query);
  }

  void changePage(int page) {
    _currentPage = page;
    _emitState(searchQuery: state.searchQuery);
  }

  void _emitState({String? searchQuery}) {
    final totalPages =
    (_filteredRentals.length / itemsPerPage).ceil();

    emit(
      MyRentalLoaded(
        rentals: _filteredRentals,
        currentPage: _currentPage,
        totalPages: totalPages,
        searchQuery: searchQuery,
      ),
    );
  }
}

