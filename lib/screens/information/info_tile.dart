import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';

class InfoTile extends StatelessWidget {
  // final String title;
  final String subtitle;
  final String details;
  final String animatedDetails;
  final bool isExpanded;
  final VoidCallback onTap;

  const InfoTile({
    super.key,
    // required this.title,
    required this.subtitle,
    required this.details,
    required this.animatedDetails,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CustomAppText(
        //   text: title.toUpperCase(),
        //   fontSize: 12,
        //   color: const Color.fromARGB(255, 118, 136, 156),
        // ),

        ListTile(
          contentPadding: EdgeInsets.zero,
          title: CustomAppText(
            text: subtitle,
            fontSize: 14,
            color: AppColors.borderColor,
            fontWeight: FontWeight.bold,
          ),
          trailing: Icon(
            isExpanded
                ? Icons.keyboard_arrow_up
                : Icons.arrow_forward_ios_outlined,
            size: 24,
            color: Colors.brown,
          ),
          onTap: onTap,
        ),

        AnimatedSize(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Padding(
                  padding: EdgeInsets.only(
                    right: responsiveWidth(context, 30),
                    bottom: responsiveHeight(context, 10),
                  ),
                  child: CustomAppText(
                    text: animatedDetails,
                    fontSize: 12,
                    color: const Color.fromARGB(255, 118, 136, 156),
                  ),
                )
              : const SizedBox(),
        ),
        const Divider(),
      ],
    );
  }
}
