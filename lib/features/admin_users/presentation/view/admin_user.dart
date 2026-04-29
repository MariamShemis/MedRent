import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/admin_users/data/cubit/admin_user_cubit.dart';
import 'package:med_rent/features/admin_users/data/cubit/admin_user_state.dart';
import 'package:med_rent/features/admin_users/presentation/widgets/users_card.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AdminUser extends StatelessWidget {
  const AdminUser({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    context.read<AdminUsersCubit>().getUsers();
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
                onChanged: (value) {
                  context.read<AdminUsersCubit>().searchUsers(value);
                },
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<AdminUsersCubit, AdminUsersState>(
                  builder: (context, state) {
                    if (state is AdminUsersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AdminUsersSuccess) {
                      if (state.users.isEmpty) {
                        return const Center(child: Text("No Users Found"));
                      }
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                          return UsersCard(
                            user: user,
                            onBlockTap: () {
                              context.read<AdminUsersCubit>().toggleBlock(user.userId);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 10.h),
                        itemCount: state.users.length,
                      );
                    } else if (state is AdminUsersError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}