import 'package:med_rent/features/admin_users/data/models/user_model.dart';

abstract class AdminUsersState {}

class AdminUsersInitial extends AdminUsersState {}
class AdminUsersLoading extends AdminUsersState {}
class AdminUsersSuccess extends AdminUsersState {
  final List<UserModel> users;
  AdminUsersSuccess(this.users);
}
class AdminUsersError extends AdminUsersState {
  final String message;
  AdminUsersError(this.message);
}