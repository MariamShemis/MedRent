import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/my_rental/data/models/rental_model.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class MyRentalCard extends StatelessWidget {
  final RentalModel rental;

  const MyRentalCard({super.key, required this.rental});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Color(0xFF8BEA95);
      case 'pending':
        return Color(0xFFFDFF7E);
      default:
        return ColorManager.lightGrey;
    }
  }

  Color _getStatusColorText(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Color(0xFF188B1E);
      case 'pending':
        return ColorManager.greyText;
      default:
        return ColorManager.black;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return "Active";
      case 'pending':
        return "Pending Return";
      default:
        return "Completed";
    }
  }

  String _getImageUrl(String imageUrl) {
    final cleanPath = imageUrl.replaceAll('\\', '/');
    final fullUrl = 'http://graduationprojectapi.somee.com$cleanPath';
    return Uri.encodeFull(fullUrl);
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Container(
      margin: REdgeInsets.symmetric(vertical: 8),
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      _getImageUrl(rental.imageUrl),
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.medical_services_outlined,
                                  size: 50.sp,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  rental.equipmentName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                rental.equipmentName,
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 18.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              Text(
                '${appLocalizations.rentalPeriod}: ${_formatDate(rental.startDate)} - ${_formatDate(rental.endDate)}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                maxLines: 2,
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.equipmentDetails,
                      arguments: rental.equipmentId,
                    );
                  },
                  child: Text(appLocalizations.viewDetails),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 15, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(rental.status),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                _getStatusText(rental.status),
                style: GoogleFonts.inter(
                  color: _getStatusColorText(rental.status),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
