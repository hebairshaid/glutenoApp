import 'package:flutter/material.dart';
import 'package:gluteno/models/restaurant.dart';
import 'package:gluteno/screens/restaurents/restaurant_detail_screen.dart';
import 'package:gluteno/service/api_service.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';

class RecommendedRestaurants extends StatelessWidget {
  const RecommendedRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: ApiService.fetchRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final restaurants = snapshot.data ?? [];
        if (restaurants.isEmpty) return const Center(child: Text('No restaurants'));

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(
              left: responsiveWidth(context, 10),
              top: responsiveHeight(context, 10),
            ),
            child: Row(
              children: restaurants.map((restaurant) {
                return Padding(
                  padding: EdgeInsets.only(right: responsiveWidth(context, 15)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: responsiveWidth(context, 120),
                          height: responsiveHeight(context, 120),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              restaurant.imageUrl,
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
                            text: restaurant.name,
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
