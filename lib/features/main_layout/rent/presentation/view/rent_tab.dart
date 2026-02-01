import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/availability_fliter.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/category_fliter.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/equipment_grid.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/price_rate.dart';
import 'package:med_rent/features/main_layout/rent/presentation/widgets/rent_header.dart';

class RentTab extends StatelessWidget {
  const RentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
