import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final IconData icon;
  final bool showArrow;

  const ProfileButton({
    super.key,
    required this.text,
    this.onTap,
    required this.icon,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(context, 16.0),
        vertical: responsiveHeight(context, 10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: responsiveHeight(context, 85),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 134, 134, 134),
                offset: Offset(0, 4),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: responsiveHeight(context, 18.0),
              horizontal: responsiveWidth(context, 18.0),
            ),
            child: Row(
              children: [
                Container(
                  width: responsiveWidth(context, 50),
                  height: responsiveHeight(context, 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.btnColor,
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(width: responsiveWidth(context, 10)),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(width: responsiveWidth(context, 10)),
                if (showArrow)
                  Icon(
                    Icons.edit,
                    color: AppColors.textColor,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
