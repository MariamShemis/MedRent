import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/main_layout/rent/data/cubit/equipment_cubit.dart';
import 'package:med_rent/features/main_layout/rent/data/data_sources/equipment_data_source.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/availability_fliter.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/category_fliter.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/equipment_grid.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/price_rate.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/rent_header.dart';

class RentTab extends StatelessWidget {
  const RentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EquipmentCubit(
        EquipmentDataSource(Dio())
      )..getAll(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.all(16.0),
              child: Column(
                children: [
                  RentHeader(),
                  SizedBox(height: 10.h),
                  CategoryFliter(),
                  SizedBox(height: 10.h),
                  PriceRate(),
                  SizedBox(height: 10.h),
                  AvailabilityFliter(),
                  SizedBox(height: 10.h),
                  EquipmentGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
