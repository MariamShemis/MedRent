import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/main_layout/rent/data/cubit/equipment_cubit.dart';
import 'equipment_card.dart';

class EquipmentGrid extends StatelessWidget {
  const EquipmentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentCubit, EquipmentState>(
      builder: (context, state) {
        if (state is EquipmentLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is EquipmentLoaded) {
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.equipments.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final equipment = state.equipments[index];
              final ratingSummary = state.ratingSummaries[equipment.equipmentId];

              return EquipmentCard(
                equipment: equipment,
                ratingSummary: ratingSummary,
              );
            },
          );
        }
        if (state is EquipmentError) {
          return Text(state.message);
        }
        return const SizedBox();
      },
    );
  }
}
