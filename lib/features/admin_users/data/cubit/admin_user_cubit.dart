import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/features/admin_users/data/cubit/admin_user_state.dart';
import 'package:med_rent/features/admin_users/data/data_sources/admin_users_data_source.dart';
import '../models/user_model.dart';

class AdminUsersCubit extends Cubit<AdminUsersState> {
  final AdminUsersDataSource _dataSource;
  AdminUsersCubit(this._dataSource) : super(AdminUsersInitial());

  List<UserModel> allUsers = [];

  void getUsers() async {
    emit(AdminUsersLoading());
    try {
      allUsers = await _dataSource.getAllUsers();
      emit(AdminUsersSuccess(allUsers));
    } catch (e) {
      emit(AdminUsersError("Failed to load users"));
    }
  }

  void searchUsers(String query) async {
    if (query.isEmpty) {
      emit(AdminUsersSuccess(allUsers));
      return;
    }

    try {
      final results = await _dataSource.searchUsers(query);
      emit(AdminUsersSuccess(results));
    } catch (e) {
      emit(AdminUsersError("Search failed"));
    }
  }

  void toggleBlock(int userId) async {
    try {
      await _dataSource.toggleBlockUser(userId);
      getUsers();
    } catch (e) {
      emit(AdminUsersError("Action failed"));
    }
  }
}