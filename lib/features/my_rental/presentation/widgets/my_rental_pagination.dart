import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class MyRentalPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const MyRentalPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: currentPage > 0
              ? () => onPageChanged(currentPage - 1)
              : null,
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: ColorManager.lightBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorManager.darkBlue,
              size: 20,
            ),
          ),
        ),

        Row(
          children: List.generate(2, (i) {
            int pageIndex = currentPage + i;
            if (pageIndex >= totalPages) return const SizedBox();

            bool isSelected = pageIndex == currentPage;

            return GestureDetector(
              onTap: () => onPageChanged(pageIndex),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 26.w),
                padding: REdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManager.darkBlue
                      : ColorManager.lightBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${pageIndex + 1}',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : ColorManager.darkBlue,
                  ),
                ),
              ),
            );
          }),
        ),

        GestureDetector(
          onTap: currentPage < totalPages - 1
              ? () => onPageChanged(currentPage + 1)
              : null,
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: ColorManager.lightBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.darkBlue,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
