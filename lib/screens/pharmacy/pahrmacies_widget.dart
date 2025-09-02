import 'package:flutter/material.dart';
import 'package:gluteno/models/pharmacy.dart';
import 'package:gluteno/screens/pharmacy/pahrmacy_details.dart';
import 'package:gluteno/service/api_service.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';

class PharmaciesWidget extends StatelessWidget {
  const PharmaciesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pharmacy>>(
      future: ApiService.fetchPharmacies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading pharmacies"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No pharmacies found"));
        }

        final pharmacies = snapshot.data!;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 20)),
          child: Column(
            children: List.generate(pharmacies.length, (index) {
              final pharmacy = pharmacies[index];

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PharmacyDetailScreen(pharmacy: pharmacy),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: responsiveWidth(context, 80),
                          height: responsiveWidth(context, 80),
                          decoration: BoxDecoration(
                            // color: AppColors.scaffoldBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              pharmacy.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, error, stack) =>
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
                                text: pharmacy.name,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.brown,
                              ),
                              SizedBox(height: responsiveHeight(context, 4)),
                              CustomAppText(
                                text:
                                    '${pharmacy.location.address.city}, ${pharmacy.location.address.street}',
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
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
                    padding: EdgeInsets.only(top: responsiveHeight(context, 8)),
                    child: Divider(color: Colors.grey.shade300),
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
