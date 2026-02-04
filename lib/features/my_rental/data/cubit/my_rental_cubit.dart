import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/my_rental/data/cubit/my_rental_state.dart';
import 'package:med_rent/features/my_rental/data/data_sources/my_rental_data_source.dart';
import 'package:med_rent/features/my_rental/data/models/rental_model.dart';

class MyRentalCubit extends Cubit<MyRentalState> {
  final MyRentalDataSource dataSource;

  List<RentalModel> _allRentals = [];

  MyRentalCubit({required this.dataSource}) : super(MyRentalInitial());

  Future<void> loadRentals() async {
    emit(MyRentalLoading());

    try {
      final rentals = await dataSource.getUserRentals();
      _allRentals = rentals;
      emit(MyRentalLoaded(rentals: rentals));
    } catch (e) {
      emit(MyRentalError(e.toString()));
    }
  }

  void searchRentals(String query) {
    if (query.isEmpty) {
      emit(MyRentalLoaded(rentals: _allRentals));
      return;
    }

    final filtered = _allRentals.where((rental) {
      return rental.equipmentName
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    emit(MyRentalLoaded(
      rentals: filtered,
      searchQuery: query,
    ));
  }

  void clearSearch() {
    emit(MyRentalLoaded(rentals: _allRentals));
  }
}
