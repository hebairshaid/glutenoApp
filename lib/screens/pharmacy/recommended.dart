import 'package:flutter/material.dart';
import 'package:gluteno/models/pharmacy.dart';
import 'package:gluteno/screens/pharmacy/pahrmacy_details.dart';
import 'package:gluteno/service/api_service.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';

class RecommendedPharmacies extends StatelessWidget {
  const RecommendedPharmacies({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pharmacy>>(
      future: ApiService.fetchPharmacies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final pharmacies = snapshot.data ?? [];
        if (pharmacies.isEmpty) return const Center(child: Text('No pharmacies'));

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(
              left: responsiveWidth(context, 10),
              top: responsiveHeight(context, 10),
            ),
            child: Row(
              children: pharmacies.map((pharmacy) {
                return Padding(
                  padding: EdgeInsets.only(right: responsiveWidth(context, 15)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PharmacyDetailScreen(pharmacy: pharmacy),
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
                              pharmacy.imageUrl,
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
                            text: pharmacy.name,
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
