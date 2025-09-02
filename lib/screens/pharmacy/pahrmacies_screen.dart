import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/screens/pharmacy/pahrmacies_widget.dart';
import 'package:gluteno/screens/pharmacy/recommended.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/top.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';

class PharmaciesScreen extends StatelessWidget {
  const PharmaciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Top(),
                Padding(
                  padding: EdgeInsets.only(
                    top: responsiveHeight(context, 50),
                  ),
                  child: CustomAppText(
                    text: "         Pharmacies",
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            // Top(),
            // SizedBox(height: responsiveHeight(context, 20)),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: responsiveWidth(context, 20)),
            //   child: CustomAppText(
            //     text: "Pharmacies",
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.brown,
            //   ),
            // ),
            SizedBox(height: responsiveHeight(context, 50)),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveWidth(context, 30)),
              child: CustomAppText(
                text: "Recommended for you",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 88, 70, 53),
              ),
            ),

            SizedBox(height: responsiveHeight(context, 8)),

            RecommendedPharmacies(),

            SizedBox(height: responsiveHeight(context, 10)),

            Divider(color: AppColors.borderColor),

            SizedBox(height: responsiveHeight(context, 10)),

            PharmaciesWidget(),
          ],
        ),
      ),
    );
  }
}
