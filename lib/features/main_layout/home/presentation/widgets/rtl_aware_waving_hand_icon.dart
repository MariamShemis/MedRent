import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/core/language/cubit/app_localization_cubit.dart';

class RtlAwareWavingHandIcon extends StatelessWidget {
  const RtlAwareWavingHandIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLocalizationCubit, Locale>(
      builder: (context, locale) {
        final isArabic = locale.languageCode == 'ar';

        return Transform.scale(
          scaleX: isArabic ? -1 : 1,
          child: Icon(
            Icons.waving_hand,
            textDirection: TextDirection.ltr,
            color: Colors.amber.withAlpha(128),
          ),
        );
      },
    );
  }
}