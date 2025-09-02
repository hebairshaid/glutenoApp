import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/screens/stores/recommended.dart';
import 'package:gluteno/screens/stores/stores_widget.dart';
import 'package:gluteno/widgets/top.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';

class SelectButtonScreen extends StatelessWidget {
  const SelectButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
                        Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Top(),
                Padding(
                  padding: EdgeInsets.only(
                    top: responsiveHeight(context, 50),
                    left: responsiveWidth(context, 30),
                    right: responsiveWidth(context, 30)
                  ),
                  child: CustomAppText(
                    text: "Stores",
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: responsiveHeight(context, 30),
                left: responsiveWidth(context, 20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: responsiveHeight(context, 10),
                  ),
                  CustomAppText(
                    text: "Recommended for you",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 79, 85, 91),
                  ),
                ],
              ),
            ),
            RecommendedMarkets(),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: responsiveHeight(context, 10)),
              child: Divider(
                color: AppColors.borderColor,
              ),
            ),
            StoresWidget(),
          ],
        ),
      ),
    );
  }
}