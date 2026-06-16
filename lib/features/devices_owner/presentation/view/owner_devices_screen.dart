import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/devices_add_owner/presentation/view/add_devices_owner_screen.dart';
import 'package:med_rent/features/devices_owner/data/cubit/devices_owner_cubit.dart';
import 'package:med_rent/features/devices_owner/data/data_source/owner_devices_service.dart';
import 'package:med_rent/features/devices_owner/presentation/widget/devices_owner_card.dart';
import 'package:med_rent/l10n/app_localizations.dart';

import '../../../admin_doctor/presentation/widgets/card_add_doctor.dart';

class OwnerDevicesScreen extends StatefulWidget {
  const OwnerDevicesScreen({super.key});

  static Widget route() {
    return BlocProvider(
      create: (context) => DevicesOwnerCubit(OwnerDevicesService()),
      child: const OwnerDevicesScreen(),
    );
  }

  @override
  State<OwnerDevicesScreen> createState() => _OwnerDevicesScreenState();
}

class _OwnerDevicesScreenState extends State<OwnerDevicesScreen> {
  @override
  void initState() {
    super.initState();
    loadDevices();
  }

  Future<void> loadDevices() async {
    final token = await SessionService.getAuthToken();
    if (token != null && mounted) {
      context.read<DevicesOwnerCubit>().fetchOwnerDevices(token);
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
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            CardAddDoctor(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDevicesOwnerScreen(),
                  ),
                );
              },
              text: appLocalizations.addDevice,
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: BlocBuilder<DevicesOwnerCubit, DevicesOwnerState>(
                builder: (context, state) {
                  if (state is DevicesOwnerLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DevicesOwnerSuccess) {
                    if (state.devices.isEmpty) {
                      return const Center(child: Text("No devices found"));
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.devices.length,
                      itemBuilder: (context, index) {
                        return DevicesOwnerCard(device: state.devices[index]);
                      },
                    );
                  } else if (state is DevicesOwnerError) {
                    return Center(
                      child: Text(
                        state.message,
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
