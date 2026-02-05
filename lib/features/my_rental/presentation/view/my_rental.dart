import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/my_rental/data/cubit/my_rental_cubit.dart';
import 'package:med_rent/features/my_rental/data/cubit/my_rental_state.dart';
import 'package:med_rent/features/my_rental/presentation/widgets/my_rental_card.dart';
import 'package:med_rent/features/my_rental/presentation/widgets/my_rental_pagination.dart';
import 'package:med_rent/l10n/app_localizations.dart';
import '../../data/data_sources/my_rental_data_source.dart';

class MyRental extends StatefulWidget {
  const MyRental({super.key});

  @override
  State<MyRental> createState() => _MyRentalState();
}

class _MyRentalState extends State<MyRental> {
  final TextEditingController _searchController = TextEditingController();

  int currentPage = 0;
  final int itemsPerPage = 2; // كل صفحة تاخد 2 widget

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => MyRentalCubit(
        dataSource: MyRentalDataSource(),
      )..loadRentals(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(appLocalizations.myRentals),
        ),
        body: BlocBuilder<MyRentalCubit, MyRentalState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.error != null) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<MyRentalCubit>().loadRentals();
                  },
                  child: const Text('Try Again'),
                ),
              );
            }

            final totalItems = state.rentals.length;
            final totalPages = (totalItems / itemsPerPage).ceil();

            final startIndex = currentPage * itemsPerPage;
            final endIndex =
            (startIndex + itemsPerPage > totalItems) ? totalItems : startIndex + itemsPerPage;

            final paginatedRentals = state.rentals.sublist(startIndex, endIndex);

            return Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                children: [
                  CustomSearchTextField(
                    controller: _searchController,
                    hintText: appLocalizations.search_by_equipment_name,
                    iconPrefix: Iconsax.search_normal,
                    onChanged: (value) {
                      currentPage = 0;
                      context.read<MyRentalCubit>().searchRentals(value);
                    },
                  ),

                  SizedBox(height: 12.h),

                  Expanded(
                    child: paginatedRentals.isEmpty
                        ? Center(
                      child: Text(
                        "No data",
                        style: TextStyle(color: ColorManager.greyText),
                      ),
                    )
                        : ListView.builder(
                      itemCount: paginatedRentals.length,
                      itemBuilder: (context, index) {
                        return MyRentalCard(
                          rental: paginatedRentals[index],
                        );
                      },
                    ),
                  ),

                  if (totalPages > 1) ...[
                    SizedBox(height: 12.h),
                    MyRentalPagination(
                      currentPage: currentPage,
                      totalPages: totalPages,
                      onPageChanged: (page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

