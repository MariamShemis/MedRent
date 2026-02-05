import '../models/rental_model.dart';

class MyRentalState {
  final List<RentalModel> rentals;
  final bool isLoading;
  final String? error;
  final String? searchQuery;
  final int currentPage;
  final int totalPages;

  const MyRentalState({
    required this.rentals,
    this.isLoading = false,
    this.error,
    this.searchQuery,
    this.currentPage = 0,
    this.totalPages = 1,
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
    required int currentPage,
    required int totalPages,
  }) : super(
    rentals: rentals,
    searchQuery: searchQuery,
    currentPage: currentPage,
    totalPages: totalPages,
  );
}

class MyRentalError extends MyRentalState {
  MyRentalError(String error)
      : super(
    rentals: [],
    error: error,
  );
}
