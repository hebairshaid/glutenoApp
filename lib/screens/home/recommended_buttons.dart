import 'package:flutter/material.dart';
import 'package:gluteno/models/restaurant.dart';
import 'package:gluteno/models/pharmacy.dart';
import 'package:gluteno/models/stores.dart';
import 'package:gluteno/screens/restaurents/restaurant_detail_screen.dart';
import 'package:gluteno/screens/stores/selected_store.dart';
import 'package:gluteno/screens/pharmacy/pahrmacy_details.dart';
import 'package:gluteno/service/api_service.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/classes/colors.dart';

class RecommendedMix extends StatelessWidget {
  const RecommendedMix({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        ApiService.fetchRestaurants(),
        ApiService.fetchMarkets(),
        ApiService.fetchPharmacies(),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        final height = responsiveHeight(context, 220);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            height: height,
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        final restaurants = snapshot.data?[0] as List<Restaurant>? ?? [];
        final markets = snapshot.data?[1] as List<Market>? ?? [];
        final pharmacies = snapshot.data?[2] as List<Pharmacy>? ?? [];

        final List<RecommendedItem> allItems = [
          ...restaurants.take(1).map((r) => RecommendedItem.restaurant(r)),
          ...markets.take(1).map((m) => RecommendedItem.market(m)),
          ...pharmacies.take(1).map((p) => RecommendedItem.pharmacy(p)),
        ];

        if (allItems.isEmpty) {
          return SizedBox(
            height: height,
            child: const Center(child: Text('No recommendations available')),
          );
        }

        return SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(
              left: responsiveWidth(context, 10),
              top: responsiveHeight(context, 10),
              bottom: responsiveHeight(context, 10),
            ),
            itemCount: allItems.length,
            itemBuilder: (context, index) {
              final item = allItems[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: responsiveWidth(context, 15),
                  top: responsiveHeight(context, 40),
                ),
                child: GestureDetector(
                  onTap: () {
                    if (item.type == RecommendedType.restaurant) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailScreen(
                            restaurant: item.restaurant!,
                          ),
                        ),
                      );
                    } else if (item.type == RecommendedType.market) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SelectedStore(
                            market: item.market!,
                          ),
                        ),
                      );
                    } else if (item.type == RecommendedType.pharmacy) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PharmacyDetailScreen(
                            pharmacy: item.pharmacy!,
                          ),
                        ),
                      );
                    }
                  },
                  child: RecommendedMixCard(item: item),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

enum RecommendedType { restaurant, market, pharmacy }

class RecommendedItem {
  final RecommendedType type;
  final Restaurant? restaurant;
  final Market? market;
  final Pharmacy? pharmacy;

  RecommendedItem.restaurant(this.restaurant)
      : type = RecommendedType.restaurant,
        market = null,
        pharmacy = null;
  RecommendedItem.market(this.market)
      : type = RecommendedType.market,
        restaurant = null,
        pharmacy = null;
  RecommendedItem.pharmacy(this.pharmacy)
      : type = RecommendedType.pharmacy,
        restaurant = null,
        market = null;

  String get name {
    if (type == RecommendedType.restaurant) return restaurant!.name;
    if (type == RecommendedType.market) return market!.name;
    return pharmacy!.name;
  }

  String get imageUrl {
    if (type == RecommendedType.restaurant) return restaurant!.imageUrl;
    if (type == RecommendedType.market) return market!.imageUrl;
    return pharmacy!.imageUrl;
  }
}

class RecommendedMixCard extends StatelessWidget {
  final RecommendedItem item;

  const RecommendedMixCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: responsiveWidth(context, 130),
          height: responsiveHeight(context, 120),
          decoration: BoxDecoration(
            color: AppColors.btnColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(2, 2),
              )
            ],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: responsiveHeight(context, 15)),
              child: CustomAppText(
                text: item.name,
                fontSize: 12,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Positioned(
          top: -responsiveHeight(context, 40),
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: responsiveHeight(context, 40),
            backgroundImage: NetworkImage(item.imageUrl),
            backgroundColor: Colors.grey.shade200,
            onBackgroundImageError: (_, __) {},
          ),
        ),
      ],
    );
  }
}
