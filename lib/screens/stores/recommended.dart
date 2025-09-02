import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/models/stores.dart';
import 'package:gluteno/screens/stores/selected_store.dart';
import 'package:gluteno/service/api_service.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';

class RecommendedMarkets extends StatelessWidget {
  const RecommendedMarkets({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Market>>(
      future: ApiService.fetchMarkets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final markets = snapshot.data ?? [];
        if (markets.isEmpty) return const Center(child: Text('No markets'));

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(
              left: responsiveWidth(context, 10),
              top: responsiveHeight(context, 10),
            ),
            child: Row(
              children: markets.map((market) {
                return Padding(
                  padding: EdgeInsets.only(right: responsiveWidth(context, 15)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SelectedStore(market: market),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: responsiveWidth(context, 120),
                          height: responsiveHeight(context, 120),
                          decoration: BoxDecoration(
                            color: AppColors.btnColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              market.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 50);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: responsiveHeight(context, 10)),
                        SizedBox(
                          width: responsiveWidth(context, 120),
                          child: CustomAppText(
                            text: market.name,
                            fontSize: 12,
                            hasPadding: false,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
