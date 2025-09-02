import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/screens/stores/stores_widget.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TabBar(
                indicatorColor: AppColors.textColor,
                dividerColor: Colors.grey,
                isScrollable: true,
                labelColor: Colors.blueGrey,
                unselectedLabelColor: const Color.fromARGB(255, 149, 171, 182),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
                tabs: [
                  Tab(child: Text("Salty snacks")),
                  Tab(child: Text("baking ingredients")),
                  Tab(child: Text("drinks")),
                  Tab(child: Text("rice and more")),
                ]),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 8.0, horizontal: 16.0),
              child: SizedBox(
                height: responsiveHeight(context, 700),
                child: const TabBarView(
                  children: [
                    Column(
                      children: [
                        StoresWidget(),
                        StoresWidget(),
                        StoresWidget(),
                        StoresWidget(),
                      ],
                    ),
                    Column(
                      children: [
                        StoresWidget(),
                        StoresWidget(),
                        StoresWidget(),
                        StoresWidget(),
                      ],
                    ),
                    Column(
                      children: [
                        StoresWidget(),
                        StoresWidget(),
                        StoresWidget(),
                        StoresWidget(),
                      ],
                    ),
                    Column(
                      children: [
                        StoresWidget(),
                        StoresWidget(),
                        StoresWidget(),
                        StoresWidget(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
