import 'package:flutter/widgets.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/classes/images.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/top.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            
            Container(
                height: responsiveHeight(context, 350),
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.btnColor),
                child: Image.asset(
                  AppImages.appLogo,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )),
                Positioned(
                  top: responsiveHeight(context, 5),
                  left: responsiveWidth(context, 5),
                  right: responsiveWidth(context, 5),
                  child: Top())
          ],
        ),
      ],
    );
  }
}
