import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/notification/data/cubit/notification_cubit.dart';
import 'package:med_rent/features/notification/data/cubit/notification_state.dart';
import 'package:med_rent/features/notification/presentation/widgets/custom_my_notification_card.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String role =
        ModalRoute.of(context)!.settings.arguments as String? ?? 'Patient';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appLocalizations.notifications,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: ColorManager.darkBlue,
                          fontSize: 22.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            context.read<NotificationCubit>().markAllAsRead(),
                        child: Text(
                          appLocalizations.mark_all_as_read,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.darkBlue,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Divider(thickness: 1, color: ColorManager.lightGrey),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      color: ColorManager.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16.r),
                      ),
                      child: Padding(
                        padding: REdgeInsets.all(8.0),
                        child: Expanded(
                          child: _buildBody(state, role, appLocalizations),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.symmetric(vertical: 20.h),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            color: ColorManager.darkBlue,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            appLocalizations.back_to_home,
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(
                                  color: ColorManager.darkBlue,
                                  fontSize: 16.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    NotificationState state,
    String role,
    AppLocalizations appLocalizations,
  ) {
    if (state is NotificationLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NotificationError) {
      return Center(child: Text(state.message));
    } else if (state is NotificationSuccess) {
      if (state.notifications.isEmpty) {
        return const Center(child: Text("No notifications yet"));
      }
      return ListView.separated(
        itemCount: state.notifications.length,
        separatorBuilder: (context, index) => Divider(
          height: 25.h,
          color: ColorManager.lightGrey.withOpacity(0.5),
        ),
        itemBuilder: (context, index) {
          final notification = state.notifications[index];
          final cubit = context.read<NotificationCubit>();
          final bool isBooking = cubit.isBookingNotification(
            notification.title,
            notification.message,
          );
          return CustomMyNotificationCard(
            role: role,
            createdAt: notification.createdAt,
            isRead: notification.isRead,
            isBooking: isBooking,
            title: notification.title,
            message: notification.message,
            onTap: () => cubit.markAsRead(notification.notificationId),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
