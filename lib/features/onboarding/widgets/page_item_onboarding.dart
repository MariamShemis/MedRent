import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/onboarding/model/onboarding_model.dart';

class PageItemOnboarding extends StatelessWidget {
  const PageItemOnboarding({super.key, required this.model});
  final OnboardingModel model;

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(model.image),
        SizedBox(height: 32.h,),
        Text(model.name , style: Theme.of(context).textTheme.headlineMedium,),
        SizedBox(height: 10.h,),
        Text(model.description , style: Theme.of(context).textTheme.bodyMedium,),
      ],
    );
  }
}
