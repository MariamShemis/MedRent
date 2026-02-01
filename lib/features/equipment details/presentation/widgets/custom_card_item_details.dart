import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCardItemDetails extends StatelessWidget {
  const CustomCardItemDetails({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: REdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16.r),
      ),
      child: Padding(
        padding: REdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
            child: Image.network(image ,fit: BoxFit.contain,  )),
      ),
    );
  }
}
