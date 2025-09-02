import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/screens/home/location.dart';
import 'package:gluteno/screens/profile/profile.dart';
import 'package:gluteno/screens/home/code_scanner.dart';
import 'package:gluteno/screens/home/home.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        backgroundColor: AppColors.btnColor,
        context,
        screens: [
          HomeScreen(),
          Location(),
          CodeScanner(),
          ProfileScreen()
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_outlined,
                    size: responsiveHeight(context, 30),
                    color: AppColors.textColor),
                SizedBox(height: 2),
                Text("Home",
                    style: TextStyle(fontSize: 12, color: AppColors.textColor)),
              ],
            ),
            activeColorPrimary: AppColors.textColor,
            inactiveColorPrimary: const Color.fromARGB(106, 121, 85, 72),
          ),
          PersistentBottomNavBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on,
                    size: responsiveHeight(context, 30),
                    color: AppColors.textColor),
                SizedBox(height: 2),
                Text("Location",
                    style: TextStyle(fontSize: 12, color: AppColors.textColor)),
              ],
            ),
            activeColorPrimary: AppColors.textColor,
            inactiveColorPrimary: const Color.fromARGB(106, 121, 85, 72),
          ),
          PersistentBottomNavBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_2,
                    size: responsiveHeight(context, 30),
                    color: AppColors.textColor),
                SizedBox(height: 2),
                Text("Scan",
                    style: TextStyle(fontSize: 12, color: AppColors.textColor)),
              ],
            ),
            activeColorPrimary: AppColors.textColor,
            inactiveColorPrimary: const Color.fromARGB(106, 121, 85, 72),
          ),
          PersistentBottomNavBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_2_outlined,
                    size: responsiveHeight(context, 30),
                    color: AppColors.textColor),
                SizedBox(height: 2),
                Text("Profile",
                    style: TextStyle(fontSize: 12, color: AppColors.textColor)),
              ],
            ),
            activeColorPrimary: AppColors.textColor,
            inactiveColorPrimary: const Color.fromARGB(106, 121, 85, 72),
          ),
        ],
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
