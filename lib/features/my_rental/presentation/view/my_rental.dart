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

  late MyRentalCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = MyRentalCubit(
      dataSource: MyRentalDataSource(),
    )..loadRentals();
  }

  @override
  void dispose() {
    _searchController.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: cubit,
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
              return const Center(child: CircularProgressIndicator());
            }

            final totalItems = state.rentals.length;

            final startIndex =
                state.currentPage * cubit.itemsPerPage;
            final endIndex =
            (startIndex + cubit.itemsPerPage > totalItems)
                ? totalItems
                : startIndex + cubit.itemsPerPage;

            final paginatedRentals =
            state.rentals.sublist(startIndex, endIndex);

            return Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                children: [
                  CustomSearchTextField(
                    controller: _searchController,
                    hintText:
                    appLocalizations.search_by_equipment_name,
                    iconPrefix: Iconsax.search_normal,
                    onChanged: (value) {
                      cubit.searchRentals(value);
                    },
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: paginatedRentals.isEmpty
                        ? Center(
                      child: Text(
                        'No data',
                        style: TextStyle(
                          color: ColorManager.greyText,
                        ),
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
                  if (state.totalPages > 1)
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: MyRentalPagination(
                        currentPage: state.currentPage,
                        totalPages: state.totalPages,
                        onPageChanged: (page) {
                          cubit.changePage(page);
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
