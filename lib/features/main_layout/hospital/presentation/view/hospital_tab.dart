import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/main_layout/hospital/data/cubit/hospital_cubit.dart';
import 'package:med_rent/features/main_layout/hospital/data/cubit/hospital_state.dart';
import 'package:med_rent/features/main_layout/hospital/presentation/widgets/custom_card_hospital.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class HospitalTab extends StatelessWidget {
  const HospitalTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.findHospital,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 16.h),
              CustomSearchTextField(
                hintText: appLocalizations.search_by_location_or_hospital_name,
                iconPrefix: Iconsax.search_normal4,
                onChanged: (value) {
                  context.read<HospitalCubit>().searchOrGetAll(value);
                },
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: BlocBuilder<HospitalCubit, HospitalState>(
                  builder: (context, state) {
                    if (state is HospitalLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is HospitalLoaded) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                        itemCount: state.hospitals.length,
                        itemBuilder: (context, index) {
                          return CustomCardHospital(
                            model: state.hospitals[index],
                          );
                        },
                      );
                    }
                    if (state is HospitalError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
