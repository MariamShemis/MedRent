import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/hospital_details/data/cubit/hospital_details_cubit.dart';
import 'package:med_rent/features/hospital_details/data/cubit/hospital_details_state.dart';
import 'package:med_rent/features/hospital_details/presentation/widgets/custom_department_hospitals.dart';
import 'package:med_rent/features/hospital_details/presentation/widgets/custom_patient_reviews.dart';
import 'package:med_rent/features/hospital_details/presentation/widgets/hospital_details_header.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class HospitalDetails extends StatelessWidget {
  final int hospitalId;

  const HospitalDetails({super.key, required this.hospitalId});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.hospitalDetails),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: BlocBuilder<HospitalDetailsCubit, HospitalDetailsState>(
            builder: (context, state) {
              if (state is HospitalDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HospitalDetailsLoaded) {
                final hospital = state.hospital;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HospitalDetailsHeader(
                        model: hospital,
                      ),
                      SizedBox(height: 20.h),
                      CustomDepartmentHospitals(departments: hospital.departments),
                      SizedBox(height: 20.h),
                      Text(
                        "${appLocalizations.about} ${hospital.name}",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        hospital.description ?? "",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 20.h),
                      CustomPatientReviews(
                        reviews: state.reviews,
                      ),
                      SizedBox(height: 25.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(appLocalizations.bookNow),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is HospitalDetailsError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
