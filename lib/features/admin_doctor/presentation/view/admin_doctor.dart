import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/admin_doctor/data/cubit/admin_doctors_cubit.dart';
import 'package:med_rent/features/admin_doctor/data/cubit/admin_doctors_state.dart';
import 'package:med_rent/features/admin_doctor/presentation/widgets/admin_doctor_card.dart';
import 'package:med_rent/features/admin_doctor/presentation/widgets/card_add_doctor.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AdminDoctor extends StatefulWidget {
  const AdminDoctor({super.key});

  @override
  State<AdminDoctor> createState() => _AdminDoctorState();
}

class _AdminDoctorState extends State<AdminDoctor> {
  String? selectedSpecialization;
  String currentSearchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<AdminDoctorsCubit>().getDoctors();
  }

  List<String> _getUniqueSpecs(dynamic doctors) {
    final specs = doctors
        .map((d) => d.specialization as String)
        .toSet()
        .toList();
    specs.removeWhere((element) => element == "Specialist");
    specs.sort();
    return ["All", ...specs];
  }

  void _triggerSearch() {
    if (currentSearchQuery.isEmpty && selectedSpecialization == null) {
      context.read<AdminDoctorsCubit>().getDoctors();
    } else {
      context.read<AdminDoctorsCubit>().searchDoctors(
        name: currentSearchQuery,
        spec: selectedSpecialization,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.doctor),
      ),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CardAddDoctor(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.adminAddDoctor),
                text: appLocalizations.addDoctor,
              ),
            ),
            SizedBox(height: 16.h),
            CustomSearchTextField(
              hintText: appLocalizations.search_by_Name,
              iconPrefix: Iconsax.search_normal4,
              onChanged: (value) {
                currentSearchQuery = value;
                _triggerSearch();
              },
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<AdminDoctorsCubit, AdminDoctorsState>(
                builder: (context, state) {
                  if (state is AdminDoctorsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is AdminDoctorsSuccess) {
                    final allSpecs = _getUniqueSpecs(state.doctors);
                    return Column(
                      children: [
                        SizedBox(
                          height: 45.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: allSpecs.length,
                            itemBuilder: (context, index) {
                              final spec = allSpecs[index];
                              bool isSelected =
                                  (selectedSpecialization == spec) ||
                                  (spec == "All" &&
                                      selectedSpecialization == null);
                              return Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: FilterChip(
                                  label: Text(spec),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    setState(() {
                                      selectedSpecialization = (spec == "All")
                                          ? null
                                          : spec;
                                    });
                                    _triggerSearch();
                                  },
                                  selectedColor: ColorManager.secondary
                                      .withOpacity(0.2),
                                  checkmarkColor: ColorManager.secondary,
                                  labelStyle: TextStyle(
                                    color: isSelected
                                        ? ColorManager.secondary
                                        : ColorManager.greyText,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 12.sp,
                                  ),
                                  backgroundColor: ColorManager.lightBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                    side: BorderSide(
                                      color: isSelected
                                          ? ColorManager.secondary
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: state.doctors.isEmpty
                              ? const Center(child: Text("No doctors found"))
                              : GridView.builder(
                                  padding: REdgeInsets.only(top: 10),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 12.w,
                                        mainAxisSpacing: 12.h,
                                        childAspectRatio: 0.58,
                                      ),
                                  itemCount: state.doctors.length,
                                  itemBuilder: (context, index) {
                                    return AdminDoctorCard(
                                      model: state.doctors[index],
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  }
                  if (state is AdminDoctorsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
