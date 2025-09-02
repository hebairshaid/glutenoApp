import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/buttons.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: responsiveHeight(context, 50),
          left: responsiveWidth(context, 10),
          // right: responsiveWidth(context, 30),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: "",
                      onTap: () {
                        Navigator.pop(context);
                      },
                      height: responsiveHeight(context, 40),
                      width: responsiveWidth(context, 40),
                      radius: 100,
                      iconData: Icons.arrow_back_ios_rounded,
                      size: 20,
                      padding: EdgeInsets.all(0),
                      borderColor: AppColors.borderColor,
                      borderWidth: 1,
                    ),
                    // CustomButton(
                    //   text: "",
                    //   onTap: () {},
                    //   height: responsiveHeight(context, 40),
                    //   width: responsiveWidth(context, 40),
                    //   radius: 100,
                    //   iconData: Icons.search,
                    //   size: 20,
                    //   padding: EdgeInsets.all(0),
                    //   borderColor: AppColors.borderColor,
                    //   borderWidth: 1,
                    // ),
                  ],
                ),
          )
          ])
          )
          );
  }
}