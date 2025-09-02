import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/models/stores.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/top.dart';

class SelectedStore extends StatelessWidget {
  final Market market;

  const SelectedStore({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Top(),
          SizedBox(
            height: responsiveHeight(context, 10),
          ),
          Container(
            width: double.infinity,
            height: responsiveHeight(context, 180),
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(
                  market.imageUrl.isNotEmpty
                      ? market.imageUrl
                      : "https://via.placeholder.com/150",
                ),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(12),
            alignment: Alignment.topLeft,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth(context, 20),
              vertical: responsiveHeight(context, 10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppText(
                  text: market.name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: market.products.length,
              itemBuilder: (context, index) {
                final product = market.products[index];

                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: responsiveHeight(context, 5),
                    horizontal: responsiveWidth(context, 20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4EE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: CustomAppText(
                        text: product.name,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: CustomAppText(
                        text: product.description,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      trailing: CustomAppText(
                        text: "${product.price.toStringAsFixed(2)} JD",
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
