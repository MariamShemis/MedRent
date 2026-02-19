import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/rent_payment/presentation/model/rental_model.dart';
import 'package:med_rent/features/rent_payment/presentation/widgets/rental_summary_card.dart';

class RentPayment extends StatelessWidget {
  const RentPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyData = RentalModel(
      equipmentName: "Electric wheelchair",
      equipmentDescription: "High-Performance Done",
      equipmentImage:
          "https://images.pexels.com/photos/7539782/pexels-photo-7539782.jpeg?auto=compress&cs=tinysrgb&h=400&fit=crop&crop=focalpoint&dpr=2",
      startDate: "November 21, 2025",
      endDate: "November 23, 2025",
      rentalFee: 21.00,
      insuranceFee: 6.00,
      taxesAndFees: 3.00,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          "Confirm Your Rental",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 20.sp,
            color: const Color(0Xff031B4E),
          ),
        ),
        actions: [SizedBox(width: 48.w)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // عشان الكلمة تيجي عالشمال
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ), // مسافة بسيطة من الجنب والتحت
                  child: Text(
                    "Rental Summary",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0Xff020A19),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(child: RentalSummaryCard(model: dummyData)),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
