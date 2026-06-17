import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "1. ${appLocalizations.paymentMethod}",
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF031B4E),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F7FA),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(
                Icons.credit_card,
                color: const Color(0xFF031B4E),
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  appLocalizations.secure_payment_via_Stripe,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF020A19),
                  ),
                ),
              ),
              Icon(
                Icons.lock_outline,
                color: Colors.green,
                size: 20.sp,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 14.sp,
                color: Colors.green,
              ),
              SizedBox(width: 4.w),
              Text(
                appLocalizations.sSL_SecuredPayment,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
