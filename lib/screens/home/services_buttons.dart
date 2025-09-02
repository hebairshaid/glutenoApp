import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';

class ServicesButtons extends StatelessWidget {
  const ServicesButtons({super.key, required this.image, required this.text , required this.onTap});

  final String text;
  final String image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal  : responsiveWidth(context, 10)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: responsiveHeight(context, 100),
          width: responsiveWidth(context, 110),
          decoration: BoxDecoration(
            color: AppColors.btnColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Image.asset(
                image,
                height: responsiveHeight(context, 60),
              ),
              SizedBox(
                height: responsiveHeight(context, 10),
              ),
              CustomAppText(
                text: text,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
