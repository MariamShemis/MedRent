import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/language/cubit/app_localization_cubit.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/core/routes/route_generator.dart';
import 'package:med_rent/core/theme/theme_manager.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class MedRent extends StatelessWidget {
  const MedRent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(385, 820),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AppLocalizationCubit(),
          child: BlocBuilder<AppLocalizationCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: RoutesManager.router,
                initialRoute: AppRoutes.splash,
                theme: ThemeManager.lightTheme,
                locale: locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                builder: (context, child) {
                  return Directionality(
                    textDirection: locale.languageCode == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: child!,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}