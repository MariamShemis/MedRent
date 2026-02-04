import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/my_rental/data/cubit/my_rental_cubit.dart';
import 'package:med_rent/features/my_rental/data/cubit/my_rental_state.dart';
import 'package:med_rent/features/my_rental/presentation/widgets/my_rental_card.dart';
import 'package:med_rent/l10n/app_localizations.dart';
import '../../data/data_sources/my_rental_data_source.dart';

class MyRental extends StatefulWidget {
  const MyRental({super.key});

  @override
  State<MyRental> createState() => _MyRentalState();
}

class _MyRentalState extends State<MyRental> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyRentalCubit(
        dataSource: MyRentalDataSource(),
      )..loadRentals(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(AppLocalizations.of(context)!.myRentals),
        ),
        body: BlocBuilder<MyRentalCubit, MyRentalState>(
          builder: (context, state) {
            List rentals = [];
            String? searchQuery;
            bool isLoading = false;

            if (state is MyRentalLoading) {
              rentals = state.rentals;
              isLoading = true;
            } else if (state is MyRentalLoaded) {
              rentals = state.rentals;
              searchQuery = state.searchQuery;
            } else if (state is MyRentalError) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<MyRentalCubit>().loadRentals();
                  },
                  child: const Text('Try Again'),
                ),
              );
            }

            return Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                children: [
                  CustomSearchTextField(
                    controller: _searchController,
                    hintText: AppLocalizations.of(context)!
                        .search_by_equipment_name,
                    onChanged: (value) {
                      context.read<MyRentalCubit>().searchRentals(value);
                    },
                    iconPrefix: Iconsax.search_normal,
                  ),

                  SizedBox(height: 12.h),

                  Expanded(
                    child: isLoading && rentals.isEmpty
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : rentals.isEmpty
                        ? Container()
                        : ListView.builder(
                      itemCount: rentals.length,
                      itemBuilder: (context, index) {
                        return MyRentalCard(
                          rental: rentals[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
