import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/notification/presentation/widgets/custom_my_notification_card.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.notifications,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorManager.darkBlue,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      appLocalizations.mark_all_as_read,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Divider(
                thickness: 2,
                color: ColorManager.lightGrey,
                endIndent: 5.w,
                indent: 5.w,
              ),
              SizedBox(height: 24.h),
              CustomMyNotificationCard(
                isRead: isSelected,
                onTap: () {
                  isSelected != isSelected;
                  setState(() {});
                },
              ),
              SizedBox(height: 30.h),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 10.w),
                    Text(
                      appLocalizations.back_to_home,
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(color: ColorManager.darkBlue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
