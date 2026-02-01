import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class CategoryFliter extends StatefulWidget {
  const CategoryFliter({super.key});

  @override
  State<CategoryFliter> createState() => _CategoryFliterState();
}

class _CategoryFliterState extends State<CategoryFliter> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    final List<String> categories = [
      appLocalizations.oxygen,
      appLocalizations.wheelchairs,
      appLocalizations.hospitalBeds,
      appLocalizations.walkersAndCanes,
      appLocalizations.patientLifts,
    ];

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
          trailing: Icon(Icons.keyboard_arrow_down_rounded , color: ColorManager.darkBlue,),
          title: Text(
            appLocalizations.category,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 16.sp,
              color: ColorManager.darkBlue,
            ),
          ),
          children: [
            Column(
              children: categories.map((category) {
                return InkWell(
                  onTap: () => setState(() => selectedValue = category),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h , horizontal: 12.w),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Radio<String>(value: category, groupValue: selectedValue, activeColor: ColorManager.secondary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity(horizontal: -4 , vertical: -4),
                          onChanged: (String? value) {
                            setState(() => selectedValue = value
                             
                            );
                          },),
                        ),
                        SizedBox(width: 4.w,),
                        
                        Text(
                          category,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade700,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10.h)
          ],
          
         
        ),
      ),
    );
  }
}
