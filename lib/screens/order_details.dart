import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/buttons.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: responsiveHeight(context, 50),
          horizontal: responsiveWidth(context, 30),
        ),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: CustomButton(
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
                ),
                SizedBox(
                  height: responsiveHeight(context, 40),
                ),
                CustomAppText(
                  text: "Your Order",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                CustomAppText(
                  text: "Baked Green Pea Snacks",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: const Color.fromARGB(255, 79, 85, 91),
                ),
                Padding(
                  padding: EdgeInsets.only(top: responsiveHeight(context, 10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: "",
                        onTap: () {},
                        height: responsiveHeight(context, 30),
                        width: responsiveWidth(context, 30),
                        radius: 100,
                        iconData: Icons.delete_outline,
                        size: 20,
                        padding:
                            EdgeInsets.only(right: responsiveWidth(context, 0)),
                      ),
                      CustomAppText(
                        text: "1",
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        hasPadding: true,
                      ),
                      CustomButton(
                        text: "",
                        onTap: () {},
                        height: responsiveHeight(context, 30),
                        width: responsiveWidth(context, 30),
                        radius: 100,
                        iconData: Icons.add,
                        size: 20,
                        padding:
                            EdgeInsets.only(left: responsiveWidth(context, 0)),
                      ),
                      SizedBox(
                        width: responsiveWidth(context, 180),
                      ),
                      CustomAppText(
                        text: "2.00 JD",
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        hasPadding: false,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.textColor,
                  thickness: 1,
                  endIndent: 0,
                  indent: 0,
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                CustomAppText(
                  text: "Payment Summary",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAppText(
                      text: "Basket Total (Incl.tax)",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 79, 85, 91),
                    ),
                    CustomAppText(
                      text: "5.00 JD",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 79, 85, 91),
                    ),
                  ],
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAppText(
                      text: "Delivary Fee",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 79, 85, 91),
                    ),
                    CustomAppText(
                      text: "1.00 JD",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 79, 85, 91),
                    ),
                  ],
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAppText(
                      text: "Sevice Fee",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 79, 85, 91),
                    ),
                    CustomAppText(
                      text: "0.15 JD",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 79, 85, 91),
                    ),
                  ],
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                Divider(
                  color: AppColors.textColor,
                  thickness: 1,
                  endIndent: 0,
                  indent: 0,
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAppText(
                      text: "Order Total",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomAppText(
                      text: "0.15 JD",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 79, 85, 91),
                    ),
                  ],
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                Divider(
                  color: AppColors.textColor,
                  thickness: 1,
                  endIndent: 0,
                  indent: 0,
                ),
                CustomAppText(
                  text: "Deliver To",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: "",
                      onTap: () {},
                      height: responsiveHeight(context, 40),
                      width: responsiveWidth(context, 40),
                      radius: 100,
                      iconData: Icons.location_on,
                      size: 20,
                      padding: EdgeInsets.all(0),
                      borderColor: AppColors.borderColor,
                      borderWidth: 1,
                    ),
                    CustomAppText(
                      text: "Khalda , Alayan st.",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 79, 85, 91),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.borderColor,
                      size: responsiveWidth(context, 30),
                    )
                  ],
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                Divider(
                  color: AppColors.textColor,
                  thickness: 1,
                  endIndent: 0,
                  indent: 0,
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                CustomAppText(
                  text: "Pay with",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: responsiveHeight(context, 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.money,
                      size: responsiveWidth(context, 35),
                      color: AppColors.borderColor,
                    ),
                    CustomAppText(
                      text: "Cash",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 79, 85, 91),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.borderColor,
                      size: responsiveWidth(context, 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: responsiveHeight(context, 40),
                ),
                CustomButton(
                  text: "Place Order For 6.15 JD",
                  fontSize: 16,
                  onTap: () {},
                  height: responsiveHeight(context, 40),
                  width: responsiveWidth(context, 300),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
