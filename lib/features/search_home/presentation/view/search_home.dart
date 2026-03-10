import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/search_home/data/cubit/search_cubit.dart';
import 'package:med_rent/features/search_home/presentation/widgets/custom_card_search_item.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class SearchHome extends StatelessWidget {
  const SearchHome({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16),
          child: Column(
            children: [
              CustomSearchTextField(
                isFocus: true,
                hintText: appLocalizations.search_for_hospitals_or_equipment,
                iconPrefix: Iconsax.search_normal4,
                onChanged: (value) {
                  context.read<SearchCubit>().search(value);
                },
                iconSuffix: InkWell(
                  onTap: () {
                    context.read<SearchCubit>().clearSearch();
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                    },);
                  },
                  child: Icon(Icons.close, color: ColorManager.greyText),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is SearchSuccess) {
                      if (state.hospitals.isEmpty && state.equipments.isEmpty) {
                        return const Center(child: Text("No results"));
                      }
                      return ListView(
                        children: [
                          if (state.equipments.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only( bottom: 10.h),
                              child: Text(
                                "Equipment",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ...state.equipments.map(
                                (equipment) => Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: CustomCardSearchItem(equipment: equipment),
                            ),
                          ),
                          if (state.hospitals.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                              child: Text(
                                "Hospitals",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ...state.hospitals.map(
                            (hospital) => Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: CustomCardSearchItem(hospital: hospital),
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is SearchError) {
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
