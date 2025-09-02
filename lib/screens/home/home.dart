import 'package:flutter/material.dart';
import 'package:gluteno/auth/login/user_login.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/classes/images.dart';
import 'package:gluteno/screens/home/recommended_buttons.dart';
import 'package:gluteno/screens/information/general_info_page.dart';
import 'package:gluteno/screens/pharmacy/pahrmacies_screen.dart';
import 'package:gluteno/screens/restaurents/restaurents.dart';
import 'package:gluteno/screens/stores/stores_screen.dart';
import 'package:gluteno/screens/recipes/recipes.dart';
import 'package:gluteno/utils/extension.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
// import 'package:gluteno/screens/home/search.dart';
import 'package:gluteno/screens/home/services_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsiveHeight(context, 200)),
        child: Padding(
          padding: EdgeInsets.only(
            left: responsiveWidth(context, 10),
            right: responsiveWidth(context, 10),
            top: responsiveHeight(context, 30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: CustomAppText(
                              text: "Log Out",
                              fontSize: 20,
                              color: AppColors.textColor,
                            ),
                            content: CustomAppText(
                              text: "Are you sure you want to log out?",
                              fontSize: 14,
                            ),
                            actions: [
                              TextButton(
                                child: CustomAppText(
                                  text: "Log Out",
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => UserLoginPage(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: AppColors.textColor,
                      size: responsiveHeight(context, 50),
                    ),
                  ),
                  const CustomAppText(
                    text: " Welcome!",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logoo.png",
                    height: responsiveHeight(context, 100),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search(),
          // SizedBox(height: responsiveHeight(context, 10)),

          const RecommendedMix(),

          const Divider(
            color: AppColors.textColor,
            thickness: 0.5,
          ),

          const CustomAppText(
            text: "Services",
            fontSize: 25,
            hasPadding: true,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: responsiveHeight(context, 20)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ServicesButtons(
                onTap: () {
                  context.push(RestaurentsScreen());
                },
                image: AppImages.restaurants,
                text: "Restaurents",
              ),
              ServicesButtons(
                onTap: () {
                  context.push(PharmaciesScreen());
                },
                image: AppImages.pharmacies,
                text: "Pharmacise",
              ),
              ServicesButtons(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecipesScreen()),
                  );
                },
                image: AppImages.recipes,
                text: "Recipes",
              ),
            ],
          ),

          SizedBox(height: responsiveHeight(context, 20)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ServicesButtons(
                image: AppImages.information,
                text: "Information",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GeneralInfoPage()),
                  );
                },
              ),
              ServicesButtons(
                image: AppImages.stores,
                text: "Stores",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectButtonScreen()),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
