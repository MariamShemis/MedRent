import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/dashboard_admin/data/cubit/admin_dashboard_cubit.dart';
import 'package:med_rent/features/dashboard_admin/data/data_sources/admin_dashboard_data_source.dart';
import 'package:med_rent/features/rent_payment/data/cubit/rent_payment_cubit.dart';
import 'package:med_rent/features/rent_payment/data/data_sources/rent_payment_data_source.dart';
import 'package:med_rent/features/auth/data/cubit/auth_cubit.dart';
import 'package:med_rent/features/auth/presentation/view/login_screen.dart';
import 'package:med_rent/features/auth/presentation/view/register_screen.dart';
import 'package:med_rent/features/booking/data/cubit/booking_cubit.dart';
import 'package:med_rent/features/booking/presentation/view/booking_tab.dart';
import 'package:med_rent/features/booking_payment/presentation/view/booking_payment.dart';
import 'package:med_rent/features/booking_reservation_admin/presentation/view/booking_reservation_admin.dart';
import 'package:med_rent/features/booking_reservation_doctor/presentation/view/booking_reservation_doctor.dart';
import 'package:med_rent/features/booking_reservation_e_owner/presentation/view/booking_reservation_e_owner.dart';
import 'package:med_rent/features/contact_us/data/cubit/contact_us_cubit.dart';
import 'package:med_rent/features/contact_us/presentation/view/contact_us.dart';
import 'package:med_rent/features/dashboard_admin/presentation/view/dashboard_admin.dart';
import 'package:med_rent/features/dashboard_doctor/data/cubit/dashboard_doctor_cubit.dart';
import 'package:med_rent/features/dashboard_doctor/data/data_sources/dashboard_doctor_data_source.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/view/dashboard_doctor.dart';
import 'package:med_rent/features/dashboard_equipment_owner/data/cubit/equipment_owner_dashboard_cubit.dart';
import 'package:med_rent/features/dashboard_equipment_owner/data/data_sources/equipment_owner_dashboard_data.dart';
import 'package:med_rent/features/dashboard_equipment_owner/presentation/view/dashboard_equipment_owner.dart';
import 'package:med_rent/features/equipment%20details/data/cubit/equipment_details_cubit.dart';
import 'package:med_rent/features/equipment%20details/data/data_sources/equipment_details_data_source.dart';
import 'package:med_rent/features/equipment%20details/presentation/view/equipment_details.dart';
import 'package:med_rent/features/hospital_details/data/data_sources/hospital_details_data_source.dart';
import 'package:med_rent/features/hospital_details/presentation/view/hospital_details.dart';
import 'package:med_rent/features/language/presentation/view/language_profile.dart';
import 'package:med_rent/features/location/data/cubit/location_cubit.dart';
import 'package:med_rent/features/location/data/data_sources/location_data_source.dart';
import 'package:med_rent/features/location/presentation/widgets/location_home_wrapper.dart';
import 'package:med_rent/features/main_layout/main_layout.dart';
import 'package:med_rent/features/my_rental/data/cubit/my_rental_cubit.dart';
import 'package:med_rent/features/my_rental/data/data_sources/my_rental_data_source.dart';
import 'package:med_rent/features/my_rental/presentation/view/my_rental.dart';
import 'package:med_rent/features/notification/data/cubit/notification_cubit.dart';
import 'package:med_rent/features/notification/data/data_sources/notification_remote_data_source.dart';
import 'package:med_rent/features/notification/presentation/view/my_notification.dart';
import 'package:med_rent/features/notification_setting/data/cubit/notification_settings_cubit.dart';
import 'package:med_rent/features/notification_setting/data/data_sources/notification_settings_data_source.dart';
import 'package:med_rent/features/notification_setting/presentation/view/notification_setting.dart';
import 'package:med_rent/features/onboarding/onboarding_screen.dart';
import 'package:med_rent/features/rent_payment/presentation/view/rent_payment.dart';
import 'package:med_rent/features/search_home/data/cubit/search_cubit.dart';
import 'package:med_rent/features/search_home/data/data_sources/search_remote_data_source.dart';
import 'package:med_rent/features/search_home/presentation/view/search_home.dart';
import 'package:med_rent/features/splash/splash_screen.dart';
import 'package:med_rent/features/start_screen/start_screen.dart';
import 'package:med_rent/features/update_profile/data/cubit/update_profile_cubit.dart';
import 'package:med_rent/features/update_profile/data/data_sources/update_profile_data_source.dart';
import 'package:med_rent/features/update_profile/presentation/view/personal_information.dart';

import '../../features/contact_us/data/data_sources/contact_us_data_source.dart';
import '../../features/hospital_details/data/cubit/hospital_details_cubit.dart';

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
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => AuthCubit(),
            child: const RegisterScreen(),
          ),
        );
      case AppRoutes.startScreen:
        {
          return CupertinoPageRoute(builder: (context) => const StartScreen());
        }
      case AppRoutes.login:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => AuthCubit(),
              child: const LoginScreen(),
            ),
          );
        }
      case AppRoutes.mainLayout:
        {
          return CupertinoPageRoute(builder: (context) => MainLayout());
        }
      case AppRoutes.contactUs:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  ContactUsCubit(ContactUsDataSource(apiClient: ApiClient())),
              child: ContactUs(),
            ),
          );
        }
      case AppRoutes.hospitalDetails:
        {
          final args = settings.arguments;
          final hospitalId = args is int ? args : 0;
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => HospitalDetailsCubit(
                HospitalDetailsDataSource(apiClient: ApiClient()),
              )..fetchHospitalDetails(hospitalId),
              child: HospitalDetails(hospitalId: hospitalId),
            ),
          );
        }
      case AppRoutes.personalInformation:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => UpdateProfileCubit(
                UpdateProfileDataSource(apiClient: ApiClient()),
              ),
              child: const PersonalInformation(),
            ),
          );
        }
      case AppRoutes.rentPayment:
        {
          final args = settings.arguments;
          final rentalId = args is int ? args : 0;
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => RentPaymentCubit(
                dataSource: RentPaymentDataSource(apiClient: ApiClient()),
              ),
              child: RentPayment(rentalId: rentalId),
            ),
          );
        }
      case AppRoutes.languageProfile:
        {
          return CupertinoPageRoute(builder: (context) => LanguageProfile());
        }
      case AppRoutes.myNotification:
        {
          final args = settings.arguments;
          final role = args is String ? args : 'Patient';
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => NotificationCubit(
                NotificationRemoteDataSource(ApiClient()),
              ),
              child: const MyNotification(),
            ),
            settings: settings,
          );
        }
      case AppRoutes.notificationSetting:
        {
          final args = settings.arguments;
          final role = args is String ? args : 'Patient';
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => NotificationSettingsCubit(
                NotificationSettingsDataSource(ApiClient()),
              )..fetchSettings(),
              child: NotificationSetting(),
            ),
            settings: settings,
          );
        }
      case AppRoutes.dashboardDoctor:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => DoctorDashboardCubit(
                DoctorDashboardRemoteDataSource(ApiClient()),
              ),
              child: const Dashboard(),
            ),
          );
        }
      case AppRoutes.dashboardAdmin:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AdminDashboardCubit(
                AdminDashboardDataSource(ApiClient()),
              ),
              child: const DashboardAdmin(),
            ),
          );
        }
      case AppRoutes.dashboardEOwner:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => EquipmentOwnerDashboardCubit(
                EquipmentOwnerDashboardData(ApiClient()),
              )..loadDashboard(),
              child: DashboardEquipmentOwner(),
            ),
          );
        }
      case AppRoutes.bookingReservationDoctor:
        {
          return CupertinoPageRoute(
            builder: (context) => BookingReservationDoctor(),
          );
        }
      case AppRoutes.bookingReservationAdmin:
        {
          return CupertinoPageRoute(
            builder: (context) => BookingReservationAdmin(),
          );
        }
      case AppRoutes.bookingReservationEOwner:
        {
          return CupertinoPageRoute(
            builder: (context) => BookingReservationEOwner(),
          );
        }
      case AppRoutes.searchHome:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  SearchCubit(SearchRemoteDataSource(apiClient: ApiClient())),
              child: const SearchHome(),
            ),
          );
        }
      case AppRoutes.bookingPayment:
        {
          return CupertinoPageRoute(builder: (context) => BookingPayment());
        }
      case AppRoutes.booking:
        {
          final args = settings.arguments;
          final hospitalId = args is int ? args : 0;
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  BookingCubit(ApiClient())..loadHospitalDetails(hospitalId),
              child: BookingTab(selectedHospitalId: hospitalId),
            ),
          );
        }
      case AppRoutes.location:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  LocationCubit(LocationDataSource())..getCurrentLocation(),
              child: LocationHomeWrapper(),
            ),
          );
        }
      case AppRoutes.myRental:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => MyRentalCubit(
                dataSource: MyRentalDataSource(apiClient: ApiClient()),
              ),
              child: const MyRental(),
            ),
          );
        }
      case AppRoutes.equipmentDetails:
        {
          final args = settings.arguments;
          final equipmentId = args is int ? args : 0;
          return CupertinoPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => EquipmentDetailsCubit(
                dataSource: EquipmentDetailsDataSource(apiClient: ApiClient()),
                context: context,
              ),
              child: EquipmentDetails(equipmentId: equipmentId),
            ),
          );
        }
    }
    return null;
  }
}
