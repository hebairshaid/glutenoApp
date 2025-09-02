import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(context, 20.0),
          vertical: responsiveHeight(context, 5)),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: AppColors.btnColor,
            boxShadow: [
              BoxShadow(
                  // blurRadius: 4.0,

                  blurStyle: BlurStyle.inner)
            ],
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: responsiveWidth(context, 20),
              color: AppColors.textColor,
            ),
            SizedBox(
              width: responsiveWidth(context, 10),
            ),
            CustomAppText(
                text: "Search",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(144, 177, 148, 137))
          ],
        ),
      ),
    );
  }
}
