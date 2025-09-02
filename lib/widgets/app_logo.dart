import 'package:flutter/material.dart';
import 'package:gluteno/classes/images.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: responsiveHeight(context, height),
      width: responsiveWidth(context, width),
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.appLogo),
            SizedBox(height: responsiveHeight(context, 14)),
          ],
        ),
      ),
    );
  }
}
