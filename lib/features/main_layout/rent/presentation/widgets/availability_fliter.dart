import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/rent/data/cubit/equipment_cubit.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AvailabilityFliter extends StatefulWidget {
  const AvailabilityFliter({super.key});

  @override
  State<AvailabilityFliter> createState() => _AvailabilityFliterState();
}

class _AvailabilityFliterState extends State<AvailabilityFliter> {
  bool showAvailableOnly = false;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<EquipmentCubit, EquipmentState>(
      listener: (context, state) {
        if (state is EquipmentInitial) {
          setState(() {
            showAvailableOnly = false;
          });
        }
        // TODO: implement listener
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: ColorManager.lightBlue,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
            trailing: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ColorManager.darkBlue,
              size: 28.sp,
            ),
            title: Text(
              appLocalizations.availability,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 16.sp,
                color: ColorManager.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appLocalizations.showAvailableOnly,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0Xff676767),
                        fontSize: 20.sp,
                      ),
                    ),

                    SizedBox(
                      height: 30,
                      width: 50,
                      child: CupertinoSwitch(
                        value: showAvailableOnly,
                        activeColor: ColorManager.darkBlue,
                        trackColor: Colors.grey.shade300,
                        onChanged: (bool value) {
                          setState(() {
                            showAvailableOnly = value;
                            context.read<EquipmentCubit>().filter(
                              available: value,
                            );
                          });
                        },
                      ),
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
