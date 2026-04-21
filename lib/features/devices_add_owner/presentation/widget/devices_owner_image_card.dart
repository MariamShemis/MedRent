import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class DevicesOwnerImageCard extends StatelessWidget {
  const DevicesOwnerImageCard({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: ColorManager.white,
      elevation: 5,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onTap,
                child: SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: CustomPaint(
                    painter: _DashedRectPainter(
                      color: const Color(0xFF4086AD), // اللون الأزرق من الصورة
                      strokeWidth: 2,
                      gap: 4,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF4086AD).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xFF4086AD),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Add Image",
                            style: TextStyle(
                              color: const Color(0xFF4086AD),
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}       


class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedRectPainter({required this.color, required this.strokeWidth, required this.gap});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)));

    Path dashPath = Path();
    for (PathMetric measurePath in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < measurePath.length) {
        dashPath.addPath(measurePath.extractPath(distance, distance + gap), Offset.zero);
        distance += gap * 2;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
