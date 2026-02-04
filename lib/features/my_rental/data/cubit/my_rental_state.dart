import '../models/rental_model.dart';

class MyRentalState {
  final List<RentalModel> rentals;
  final bool isLoading;
  final String? error;
  final String? searchQuery;

  const MyRentalState({
    required this.rentals,
    this.isLoading = false,
    this.error,
    this.searchQuery,
  });
}

class MyRentalInitial extends MyRentalState {
  MyRentalInitial() : super(rentals: []);
}

class MyRentalLoading extends MyRentalState {
  MyRentalLoading() : super(rentals: [], isLoading: true);
}

class MyRentalLoaded extends MyRentalState {
  MyRentalLoaded({
    required List<RentalModel> rentals,
    String? searchQuery,
  }) : super(
    rentals: rentals,
    searchQuery: searchQuery,
  );
}

class MyRentalError extends MyRentalState {
  MyRentalError(String error)
      : super(
    rentals: [],
    error: error,
  );
}