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
    final startPage = currentPage;
    final endPage =
    (startPage + 2 > totalPages) ? totalPages : startPage + 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: currentPage > 0
              ? () => onPageChanged(currentPage - 1)
              : null,
          child: Container(
            padding: REdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorManager.lightBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: currentPage > 0
                  ? ColorManager.darkBlue
                  : ColorManager.greyText,
            ),
          ),
        ),
        Row(
          children: List.generate(endPage - startPage, (index) {
            final pageIndex = startPage + index;
            final isSelected = pageIndex == currentPage;

            return GestureDetector(
              onTap: () => onPageChanged(pageIndex),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w),
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
            padding: REdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorManager.lightBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: currentPage < totalPages - 1
                  ? ColorManager.darkBlue
                  : ColorManager.greyText,
            ),
          ),
        ),
      ],
    );
  }
}
