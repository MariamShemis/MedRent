import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/auth/data/cubit/auth_cubit.dart';
import 'package:med_rent/features/auth/presentation/view/login_screen.dart';
import 'package:med_rent/features/auth/presentation/view/register_screen.dart';
import 'package:med_rent/features/equipment%20details/data/cubit/equipment_details_cubit.dart';
import 'package:med_rent/features/equipment%20details/data/data_sources/equipment_details_data_source.dart';
import 'package:med_rent/features/equipment%20details/presentation/view/equipment_details.dart';
import 'package:med_rent/features/main_layout/main_layout.dart';
import 'package:med_rent/features/my_rental/data/cubit/my_rental_cubit.dart';
import 'package:med_rent/features/my_rental/data/data_sources/my_rental_data_source.dart';
import 'package:med_rent/features/my_rental/presentation/view/my_rental.dart';
import 'package:med_rent/features/onboarding/onboarding_screen.dart';
import 'package:med_rent/features/splash/splash_screen.dart';
import 'package:med_rent/features/start_screen/start_screen.dart';

abstract class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        {
          return CupertinoPageRoute(builder: (context) => SplashScreen());
        }
      case AppRoutes.onBoarding:
        {
          return CupertinoPageRoute(builder: (context) => OnboardingScreen());
        }
      case AppRoutes.register:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: const RegisterScreen(),
            ),
          );
        }
      case AppRoutes.startScreen:
        {
          return CupertinoPageRoute(builder: (context) => const StartScreen());
        }
      case AppRoutes.login:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: const LoginScreen(),
            ),
          );
        }
      case AppRoutes.mainLayout:
        {
          return CupertinoPageRoute(builder: (context) => MainLayout());
        }
      case AppRoutes.myRental:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  MyRentalCubit(dataSource: MyRentalDataSource()),
              child: const MyRental(),
            ),
          );
        }

      case AppRoutes.equipmentDetails:
        final args = settings.arguments; // استخدم settings.arguments مباشرة
        final equipmentId = args is int ? args : 0;
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                EquipmentDetailsCubit(dataSource: EquipmentDetailsDataSource()),
            child: EquipmentDetails(equipmentId: equipmentId),
          ),
        );
    }
    return null;
  }
}
