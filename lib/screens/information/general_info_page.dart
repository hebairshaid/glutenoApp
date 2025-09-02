import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/models/general_info.dart';
import 'package:gluteno/screens/information/info_tile.dart';
import 'package:gluteno/service/api_service.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:gluteno/widgets/buttons.dart';

class GeneralInfoPage extends StatefulWidget {
  const GeneralInfoPage({super.key});

  @override
  State<GeneralInfoPage> createState() => _GeneralInfoPageState();
}

class _GeneralInfoPageState extends State<GeneralInfoPage> {
  int? expandedIndex;
  late Future<List<GeneralInformation>> futureInfo;

  @override
  void initState() {
    super.initState();
    futureInfo = ApiService.fetchGeneralInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: FutureBuilder<List<GeneralInformation>>(
        future: futureInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final infoItems = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              buildHeader(context),
              const SizedBox(height: 16),
              ...List.generate(infoItems.length, (index) {
                final item = infoItems[index];
                final isExpanded = expandedIndex == index;

                return InfoTile(
                  // title: "SECTION ${index + 1}",
                  subtitle: item.title,
                  details: "",
                  animatedDetails: item.content,
                  isExpanded: isExpanded,
                  onTap: () {
                    setState(() {
                      expandedIndex = isExpanded ? null : index;
                    });
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsiveHeight(context, 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: "",
                  onTap: () => Navigator.pop(context),
                  height: responsiveHeight(context, 40),
                  width: responsiveWidth(context, 40),
                  radius: 100,
                  iconData: Icons.arrow_back_ios_rounded,
                  size: 24,
                  padding: EdgeInsets.zero,
                  borderColor: AppColors.borderColor,
                  borderWidth: 1,
                ),
                Image.asset(
                  "assets/images/logoo.png",
                  height: responsiveHeight(context, 100),
                )
              ],
            ),
          ),
          SizedBox(height: responsiveHeight(context, 10)),
          CustomAppText(
            text: "General",
            fontSize: 24,
            color: Color.fromARGB(255, 118, 136, 156),
          ),
          const CustomAppText(text: "Information", fontSize: 24),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
