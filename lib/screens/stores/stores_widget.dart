import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/models/stores.dart';
import 'package:gluteno/screens/stores/selected_store.dart';
import 'package:gluteno/service/api_service.dart';
import 'package:gluteno/utils/extension.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';

class StoresWidget extends StatelessWidget {
  const StoresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Market>>(
      future: ApiService.fetchMarkets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final markets = snapshot.data ?? [];

        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: responsiveWidth(context, 20)),
          child: Column(
            children: markets.map((market) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: responsiveHeight(context, 120),
                        width: responsiveWidth(context, 130),
                        decoration: BoxDecoration(
                          color: AppColors.btnColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            market.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsiveWidth(context, 10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomAppText(text: market.name, fontSize: 12),
                              SizedBox(height: responsiveHeight(context, 10)),
                              CustomAppText(
                                text: market.description,
                                fontSize: 8,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              // SizedBox(height: responsiveHeight(context, 10)),
                              // Row(
                              //   children: [
                              //     Icon(Icons.circle,
                              //         color: Colors.green,
                              //         size: responsiveHeight(context, 10)),
                              //     CustomAppText(
                              //       text: " Available",
                              //       fontSize: 8,
                              //       fontWeight: FontWeight.normal,
                              //       color: Colors.green,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.push(SelectedStore(market: market));
                        },
                        child: const Icon(
                          Icons.arrow_right,
                          color: Colors.brown,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: responsiveHeight(context, 10),
                      horizontal: responsiveWidth(context, 30),
                    ),
                    child: Divider(
                      color: const Color.fromARGB(161, 190, 146, 101),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
