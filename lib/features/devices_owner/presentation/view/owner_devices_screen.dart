import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/devices_add_owner/presentation/view/add_devices_owner_screen.dart';
import 'package:med_rent/features/devices_owner/data/cubit/devices_owner_cubit.dart';
import 'package:med_rent/features/devices_owner/data/data_source/owner_devices_service.dart';
import 'package:med_rent/features/devices_owner/presentation/widget/devices_owner_card.dart';

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
    return  Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: ColorManager.darkBlue),
        ),
        titleSpacing: 0,
        title: const Text(
          "Devices",
          style: TextStyle(
            color: ColorManager.darkBlue,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25,),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => AddDevicesOwnerScreen() ), // تأكد من الاسم هنا
              );
              },
                label: const Text(
                  "Add Device",
                  style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w600 , color: Colors.white),
                ),
                icon: const Icon(Icons.add, size: 20 , color: Colors.white,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0Xff32C8A2),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),

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
              )
            ),            
          ],
        ),
      ),
    );
  }
}