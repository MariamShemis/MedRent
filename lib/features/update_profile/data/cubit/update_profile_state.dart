abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final String message;

  UpdateProfileSuccess(this.message);
}

class UpdateProfileImageUploaded extends UpdateProfileState {
  final String imageUrl;

  UpdateProfileImageUploaded(this.imageUrl);
}

class UpdateProfileError extends UpdateProfileState {
  final String error;

  UpdateProfileError(this.error);
}
