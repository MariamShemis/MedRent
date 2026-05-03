import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/core/widgets/custom_search_text_field.dart';
import 'package:med_rent/features/admin_doctor/presentation/widgets/card_add_doctor.dart';
import 'package:med_rent/features/devices-add_admin/presentation/view/add_devices_screen.dart';
import 'package:med_rent/features/devices_admin/data/cubit/devices_admin_cubit.dart';
import 'package:med_rent/features/devices_admin/data/data_sources/devices_data.dart';
import 'package:med_rent/features/devices_admin/presentation/widget/devices_admin_card.dart';
import 'package:med_rent/features/devices_admin/presentation/widget/devices_search_bar.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  static Widget route() {
    return BlocProvider(
      create: (context) => DevicesAdminCubit(DevicesData()),
      child: const DevicesScreen(),
    );
  }

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  void initState() {
    super.initState();
    loadDevices();
  }

  Future<void> loadDevices() async {
    final token = await SessionService.getAuthToken();
    if (token != null && mounted) {
      context.read<DevicesAdminCubit>().fetchAdminDevices(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: ColorManager.darkBlue),
        ),
        titleSpacing: 0,
        title: Text(
          appLocalizations.devices,
          style: TextStyle(
            color: ColorManager.darkBlue,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 23.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CardAddDoctor(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddDevicesScreen(),
                    ),
                  );
                },
                text: appLocalizations.addDevice,
              ),
            ),
            SizedBox(height: 15.h),
            CustomSearchTextField(
              hintText: appLocalizations.search_by_Name,
              iconPrefix: Iconsax.search_normal4,
              onChanged: (query) async {
                final token = await SessionService.getAuthToken();
                if (token != null && context.mounted) {
                  context.read<DevicesAdminCubit>().searchAdminDevices(
                    token,
                    query,
                  );
                }
              },
            ),
            // DevicesSearchBar(
            //   onChanged: (query) async {
            //     final token = await SessionService.getAuthToken();
            //     if (token != null && context.mounted) {
            //       context.read<DevicesAdminCubit>().searchAdminDevices(
            //         token,
            //         query,
            //       );
            //     }
            //   },
            // ),
            SizedBox(height: 30.h),
            Expanded(
              child: BlocBuilder<DevicesAdminCubit, DevicesAdminState>(
                builder: (context, state) {
                  if (state is DevicesAdminLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DevicesAdminSuccess) {
                    if (state.equipments.isEmpty) {
                      return const Center(child: Text("No devices found"));
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.equipments.length,
                      itemBuilder: (context, index) {
                        return DeviceAdminCard(device: state.equipments[index]);
                      },
                    );
                  } else if (state is DevicesAdminError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
