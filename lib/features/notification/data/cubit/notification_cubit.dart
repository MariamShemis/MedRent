import 'package:flutter_bloc/flutter_bloc.dart';
import '../data_sources/notification_remote_data_source.dart';
import '../models/notification_model.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRemoteDataSource _dataSource;

  NotificationCubit(this._dataSource) : super(NotificationInitial());
  List<NotificationModel> _allNotifications = [];
  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    try {
      _allNotifications = await _dataSource.getMyNotifications();
      emit(NotificationSuccess(List.from(_allNotifications)));
    } catch (e) {
      emit(NotificationError("Failed to load notifications: ${e.toString()}"));
    }
  }

  void markAsRead(int notificationId) {
    final index = _allNotifications.indexWhere(
            (n) => n.notificationId == notificationId
    );

    if (index != -1) {
      _allNotifications[index].isRead = true;
      emit(NotificationSuccess(List.from(_allNotifications)));
    }
  }

  void markAllAsRead() {
    if (_allNotifications.isEmpty) return;

    for (var notification in _allNotifications) {
      notification.isRead = true;
    }
    emit(NotificationSuccess(List.from(_allNotifications)));
  }

  bool isBookingNotification(String title, String message) {
    final combinedText = (title + " " + message).toLowerCase();
    if (combinedText.contains('doctor') ||
        combinedText.contains('booking') ||
        combinedText.contains('consultation')) {
      return true;
    }
    return false;
  }
}