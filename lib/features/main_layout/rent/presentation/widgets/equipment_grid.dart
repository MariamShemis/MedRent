import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/main_layout/rent/model/equipment.dart';
import 'equipment_card.dart';

class EquipmentGrid extends StatelessWidget {
  const EquipmentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EquipmentModel> equipments = [
      EquipmentModel(name: "Medical bed", price: 25, rating: 4, reviewsCount: 120, image: "https://images.pexels.com/photos/35842222/pexels-photo-35842222.jpeg"),
      EquipmentModel(name: "Wheelchair", price: 30, rating: 5, reviewsCount: 85, image: "https://images.pexels.com/photos/35842222/pexels-photo-35842222.jpeg"),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: equipments.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) => EquipmentCard(equipment: equipments[index]),
    );
  }
}