
import 'package:flutter/material.dart';
import 'package:gluteno/models/restaurant.dart';
import 'package:gluteno/service/api_service.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/screens/restaurents/restaurant_detail_screen.dart';

class RestaurentsWidget extends StatelessWidget {
  const RestaurentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: ApiService.fetchRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("error"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No restaurents"));
        }

        final restaurants = snapshot.data!;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveWidth(context, 20),
          ),
          child: Column(
            children: List.generate(restaurants.length, (index) {
              final restaurant = restaurants[index];

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailScreen(
                            restaurant: restaurant,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: responsiveHeight(context, 100),
                          width: responsiveWidth(context, 100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              restaurant.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                        ),

                        SizedBox(width: responsiveWidth(context, 12)),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomAppText(
                                text: restaurant.name,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: responsiveHeight(context, 4)),
                              CustomAppText(
                                text:
                                    '${restaurant.location.address.city}, ${restaurant.location.address.street}',
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                              // SizedBox(height: responsiveHeight(context, 4)),
                              // Row(
                              //   children: [
                              //     Icon(
                              //       Icons.circle,
                              //       color: Colors.green,
                              //       size: responsiveHeight(context, 10),
                              //     ),
                              //     SizedBox(width: responsiveWidth(context, 4)),
                              //     CustomAppText(
                              //       text: 'available',
                              //       fontSize: 10,
                              //       color: Colors.green,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),

                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.brown,
                          size: responsiveHeight(context, 18),
                          
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: responsiveHeight(context, 10),
                    ),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
