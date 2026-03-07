import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/ai_chat/presentation/view/ai_chat.dart';
import 'package:med_rent/features/main_layout/home/presentation/view/home_tab.dart';
import 'package:med_rent/features/main_layout/hospital/data/cubit/hospital_cubit.dart';
import 'package:med_rent/features/main_layout/hospital/data/data_sources/hospital_remote_data_source.dart';
import 'package:med_rent/features/main_layout/hospital/presentation/view/hospital_tab.dart';
import 'package:med_rent/features/main_layout/profile/presentation/view/profile_tab.dart';
import 'package:med_rent/features/main_layout/rent/presentation/view/rent_tab.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    BlocProvider(
      create: (context) =>
          HospitalCubit(HospitalRemoteDataSource(Dio()))..getAllHospitals(),
      child: const HospitalTab(),
    ),
    RentTab(),
    AiChat(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _buildBottomAppBar1(),
      body: _pages[selectedIndex],
    );
  }

  Container _buildBottomAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.bg2,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: BottomNavigationBar(
        backgroundColor: ColorManager.bg2,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0 ? Iconsax.home : Iconsax.home_2),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1 ? Iconsax.hospital5 : Iconsax.hospital,
            ),
            label: "Hospital",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 2 ? Iconsax.box5 : Iconsax.box),
            label: "Rent",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 3 ? Iconsax.message5 : Iconsax.message),
            label: "Ai Chat",
          ),

          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 4 ? Icons.person : Iconsax.user,
              size: selectedIndex == 4 ? 25 : 20,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Container _buildBottomAppBar1() {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      decoration: BoxDecoration(
        color: ColorManager.bg2,
        borderRadius: BorderRadius.circular(28.r),
        border: BoxBorder.symmetric(
          vertical: BorderSide(color: ColorManager.greyText, width: 1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: _onTap,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: ColorManager.darkBlue,
          unselectedItemColor: ColorManager.greyText,
          items: [
            BottomNavigationBarItem(
              icon: Icon(selectedIndex == 0 ? Iconsax.home : Iconsax.home_2),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 1 ? Iconsax.hospital5 : Iconsax.hospital,
              ),
              label: "Hospital",
            ),
            BottomNavigationBarItem(
              icon: Icon(selectedIndex == 2 ? Iconsax.box5 : Iconsax.box),
              label: "Rent",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 3 ? Iconsax.message5 : Iconsax.message,
              ),
              label: "Ai Chat",
            ),

            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 4 ? Icons.person : Iconsax.user,
                size: selectedIndex == 4 ? 25 : 20,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
  }
}
