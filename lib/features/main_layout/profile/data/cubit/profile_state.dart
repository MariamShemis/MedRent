part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;
  final String? role;

  ProfileSuccess(this.profileModel, {this.role});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}