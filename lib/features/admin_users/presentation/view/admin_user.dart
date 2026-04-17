import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/admin_users/data/models/user_model.dart';
import 'package:med_rent/features/admin_users/presentation/widgets/users_card.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AdminUser extends StatelessWidget {
  const AdminUser({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.users),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomSearchTextField(
                hintText: appLocalizations.search_by_Name,
                iconPrefix: Iconsax.search_normal4,
                onChanged: (value) {},
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => UsersCard(
                    user: UserModel(
                      userId: 2,
                      name: "Marwa wageeh",
                      email: 'Marwa wageeh@gmail.com',
                      role: "patient",
                      totalBookings: 22,
                      status: "Active",
                    ),
                    textStatus: "Active",
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
