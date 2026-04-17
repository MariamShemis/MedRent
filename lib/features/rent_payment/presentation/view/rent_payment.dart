import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/rent_payment/data/cubit/rent_payment_cubit.dart';
import 'package:med_rent/features/rent_payment/data/cubit/rent_payment_state.dart';
import 'package:med_rent/features/rent_payment/presentation/model/rental_model.dart';
import 'package:med_rent/features/rent_payment/presentation/widgets/delivery_address_section.dart';
import 'package:med_rent/features/rent_payment/presentation/widgets/payment_section.dart';
import 'package:med_rent/features/rent_payment/presentation/widgets/rental_summary_card.dart';

class RentPayment extends StatefulWidget {
  final int rentalId;

  const RentPayment({super.key, required this.rentalId});

  @override
  State<RentPayment> createState() => _RentPaymentState();
}

class _RentPaymentState extends State<RentPayment> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<RentPaymentCubit>().loadSummary(widget.rentalId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _apartmentController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: BlocConsumer<RentPaymentCubit, RentPaymentState>(
        listener: (context, state) {
          if (state is RentPaymentSuccess) {
            _showSuccessDialog(context, state.message);
          } else if (state is RentPaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is RentPaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.darkBlue),
            );
          }

          if (state is RentPaymentError && state.summary == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 50.sp, color: Colors.red),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      state.message,
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<RentPaymentCubit>()
                          .loadSummary(widget.rentalId);
                    },
                    child: Text('Retry', style: TextStyle(fontSize: 14.sp)),
                  ),
                ],
              ),
            );
          }

          // Get summary from various states
          final summary = _getSummaryFromState(state);
          if (summary == null) return const SizedBox();

          final isProcessing = state is RentPaymentProcessing;

          final rentalModel = RentalModel(
            equipmentName: summary.equipmentName,
equipmentImage: summary.imageUrl.startsWith('http')
    ? summary.imageUrl
    : 'http://GraduationProject.somee.com${summary.imageUrl.replaceAll('\\', '/')}',
            startDate: _formatDate(summary.startDate),
            endDate: _formatDate(summary.endDate),
            rentalDays: summary.rentalDays,
            pricePerDay: summary.pricePerDay,
            rentalFee: summary.rentalFee,
            insuranceFee: summary.insuranceFee,
            taxesAndFees: summary.tax,
          );

          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "Rental Summary",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0Xff020A19),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Center(child: RentalSummaryCard(model: rentalModel)),
                      SizedBox(height: 24.h),

                      // Payment Method section
                      const PaymentSection(),
                      SizedBox(height: 24.h),

                      // Delivery Address section
                      DeliveryAddressSection(
                        nameController: _nameController,
                        phoneController: _phoneController,
                        streetController: _streetController,
                        apartmentController: _apartmentController,
                        cityController: _cityController,
                      ),
                      SizedBox(height: 30.h),

                      // Confirm Rental Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.darkBlue,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: isProcessing ? null : _onConfirmRental,
                          child: isProcessing
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Confirm Rental",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      Center(
                        child: Text(
                          'By Clicking "Confirm Rental", You agree to our\nTerms of Service and Privacy Policy.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
              if (isProcessing)
                Container(
                  color: Colors.black12,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.darkBlue,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  dynamic _getSummaryFromState(RentPaymentState state) {
    if (state is RentPaymentSummaryLoaded) return state.summary;
    if (state is RentPaymentProcessing) return state.summary;
    if (state is RentPaymentError) return state.summary;
    return null;
  }

  void _onConfirmRental() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final street = _streetController.text.trim();
    final city = _cityController.text.trim();

    if (name.isEmpty || phone.isEmpty || street.isEmpty || city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orange,
          content: Text('Please fill in all required fields'),
        ),
      );
      return;
    }

    context.read<RentPaymentCubit>().processPayment(
          rentalId: widget.rentalId,
          fullName: name,
          phone: phone,
          streetAddress: street,
          apartment: _apartmentController.text.trim(),
          city: city,
        );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      final months = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (_) {
      return isoDate;
    }
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF031B4E),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your rental has been confirmed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
