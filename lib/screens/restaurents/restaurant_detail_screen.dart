import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/models/restaurant.dart';
import 'package:gluteno/screens/home/map/map_view_screen.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/top.dart';
import 'package:latlong2/latlong.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Top(),
            SizedBox(height: responsiveHeight(context, 20)),
            Container(
              width: double.infinity,
              height: responsiveHeight(context, 200),
              color: Colors.grey.shade200,
              child: Image.network(
                restaurant.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, stack) =>
                    const Icon(Icons.broken_image, size: 80),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 20)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveWidth(context, 20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomAppText(
                      text: restaurant.name,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  Container(
                    width: responsiveWidth(context, 40),
                    height: responsiveWidth(context, 40),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.phone, color: Colors.brown),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Phone Number'),
                            content: Text(restaurant.phone),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsiveHeight(context, 4)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: responsiveWidth(context, 20)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapViewScreen(
                              destination: LatLng(
                                restaurant.location.latitude,
                                restaurant.location.longitude,
                              ),
                              title: restaurant.name,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey, size: 16),
                          SizedBox(width: responsiveWidth(context, 4)),
                          CustomAppText(
                            text:
                                '${restaurant.location.address.city}, ${restaurant.location.address.street}',
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsiveHeight(context, 50)),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: restaurant.products.length,
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey.shade300),
              itemBuilder: (context, index) {
                final prod = restaurant.products[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(context, 20),
                    vertical: responsiveHeight(context, 8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: responsiveWidth(context, 80),
                        height: responsiveHeight(context, 80),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            prod.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, error, stack) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                      SizedBox(width: responsiveWidth(context, 20)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAppText(
                              text: prod.name,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: responsiveHeight(context, 4)),
                            CustomAppText(
                              text: prod.description,
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ],
                        ),
                      ),
                      CustomAppText(
                        text: '${prod.price.toStringAsFixed(2)} JD',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: responsiveHeight(context, 20)),
          ],
        ),
      ),
    );
  }
}
