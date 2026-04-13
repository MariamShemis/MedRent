import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/booking_payment/data/cubit/booking_payment_cubit.dart';
import 'package:med_rent/features/booking_payment/data/cubit/booking_payment_state.dart';
import 'package:med_rent/features/booking_payment/presentation/model/booking_model.dart';
import 'package:med_rent/features/booking_payment/presentation/widgets/booking_summary_card.dart';
import 'package:med_rent/features/booking_payment/presentation/widgets/patient_info_section.dart';
import 'package:med_rent/features/rent_payment/presentation/widgets/payment_section.dart';

class BookingPayment extends StatefulWidget {
  final int bookingId;

  const BookingPayment({super.key, required this.bookingId});

  @override
  State<BookingPayment> createState() => _BookingPaymentState();
}

class _BookingPaymentState extends State<BookingPayment> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedBookingType = 'Emergency';

  @override
  void initState() {
    super.initState();
    context.read<BookingPaymentCubit>().loadSummary(widget.bookingId);
    _prefillUserData();
  }

  Future<void> _prefillUserData() async {
    final userData = await SessionService.getUserData();
    if (userData != null && mounted) {
      setState(() {
        _nameController.text = userData['name'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _phoneController.text = userData['phone'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
          "Payment",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 20.sp,
                color: const Color(0Xff031B4E),
              ),
        ),
        actions: [SizedBox(width: 48.w)],
      ),
      body: BlocConsumer<BookingPaymentCubit, BookingPaymentState>(
        listener: (context, state) {
          if (state is BookingPaymentSuccess) {
            _showSuccessDialog(context, state.message);
          } else if (state is BookingPaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BookingPaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.darkBlue),
            );
          }

          if (state is BookingPaymentError && state.summary == null) {
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
                          .read<BookingPaymentCubit>()
                          .loadSummary(widget.bookingId);
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

          final isProcessing = state is BookingPaymentProcessing;

          final bookingModel = BookingModel(
            doctorName: summary.doctorName,
            departmentName: summary.departmentName,
            hospitalName: summary.hospitalName,
            date: _formatDate(summary.date),
            time: _formatTime(summary.time),
            price: summary.price,
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
                      Center(child: BookingSummaryCard(model: bookingModel)),
                      SizedBox(height: 24.h),

                      // Patient Information section
                      PatientInfoSection(
                        nameController: _nameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        selectedBookingType: _selectedBookingType,
                        onBookingTypeChanged: (type) {
                          setState(() {
                            _selectedBookingType = type;
                          });
                        },
                      ),
                      SizedBox(height: 24.h),

                      // Payment Method section (reuse from rent_payment)
                      const PaymentSection(),
                      SizedBox(height: 30.h),

                      // Confirm & Pay Button
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
                          onPressed: isProcessing ? null : _onConfirmPayment,
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
                                  "Confirm & Pay",
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
                          'By Clicking "Confirm & Pay", You agree to our\nTerms of Service and Privacy Policy.',
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

  dynamic _getSummaryFromState(BookingPaymentState state) {
    if (state is BookingPaymentSummaryLoaded) return state.summary;
    if (state is BookingPaymentProcessing) return state.summary;
    if (state is BookingPaymentError) return state.summary;
    return null;
  }

  void _onConfirmPayment() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orange,
          content: Text('Please fill in all required fields'),
        ),
      );
      return;
    }

    context.read<BookingPaymentCubit>().processPayment(
          bookingId: widget.bookingId,
          patientName: name,
          patientEmail: email,
          patientPhone: phone,
          bookingType: _selectedBookingType,
        );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${days[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (_) {
      return isoDate;
    }
  }

  String _formatTime(String timeStr) {
    try {
      final parts = timeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = parts[1].padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';
      final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$hour12:$minute $period';
    } catch (_) {
      return timeStr;
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
              'Your appointment has been confirmed.',
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
