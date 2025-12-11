import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/features/main_layout/ai_chat/presentation/view/ai_chat.dart';
import 'package:med_rent/features/main_layout/home/presentation/view/home_tab.dart';
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
    HospitalTab(),
    RentTab(),
    AiChat(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomAppBar(),
      body: _pages[selectedIndex],
    );
  }

  ClipRRect _buildBottomAppBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.r),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0 ? Iconsax.home : Iconsax.home_2),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 1 ? Iconsax.hospital5 : Iconsax.hospital),
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
            icon: Icon(selectedIndex == 4 ?Icons.person : Iconsax.user , size: selectedIndex == 4 ? 25 : 20,),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  void _onTap(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
  }
}
