import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/models/recipe.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/top.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Top(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: responsiveHeight(context, 50),
                      left: responsiveWidth(context, 10),
                      right: responsiveWidth(context, 10),
                    ),
                    child: CustomAppText(
                      text: recipe.title,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: responsiveHeight(context, 16),
            ),
            Image.network(
              recipe.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            CustomAppText(text: recipe.title, fontSize: 20),
            const SizedBox(height: 16),
            CustomAppText(
              text: recipe.content,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey,
            )
          ],
        ),
      ),
    );
  }
}
