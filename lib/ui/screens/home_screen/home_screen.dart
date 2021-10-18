import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:dynamic_widget_app_task/ui/screens/home_screen/widgets/cart_items_bottom_sheet.dart';
import 'package:dynamic_widget_app_task/ui/screens/home_screen/widgets/plant_animated_card.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:dynamic_widget_app_task/controllers/plant_controller.dart';
import 'package:dynamic_widget_app_task/ui/screens/home_screen/widgets/navigation_rail_plant.dart';
import 'package:dynamic_widget_app_task/ui/screens/home_screen/widgets/plant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final textController = TextEditingController();

  bool requireConsent = false;

  @override
  Widget build(BuildContext context) {
    final PlantController plantController = Get.find();
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Row(
          children: [
            NavigationRailPlant(
              width: width,
              selectedIndex: selectedIndex,
            ),
            Expanded(
              child: Stack(
                children: [
                  Obx(
                    () => Scrollbar(
                      thickness: 8,
                      interactive: true,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: AnimationLimiter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 375),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                              children:
                                  plantsColumnElements(width, plantController),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //CartItemBottomSheet(),
                ],
              ),
            ),
          ],
        ),
        // body: Row(
        //   children: [
        //     NavigationRailPlant(
        //       width: width,
        //       selectedIndex: selectedIndex,
        //     ),
        //     Expanded(
        //       child: ListView.separated(
        //         separatorBuilder: (context, index) => SizedBox(
        //           width: 12,
        //         ),
        //         scrollDirection: Axis.horizontal,
        //         itemCount: plantController.plantList.length + 2,
        //         itemBuilder: (context, index) {
        //           if (index == 0 ||
        //               index == plantController.plantList.length + 1) {
        //             return SizedBox(
        //               width: 12,
        //             );
        //           }
        //           return PlantAnimatedCard(
        //             width: width,
        //             plant: plantController.plantList[index - 1],
        //             index: index - 1,
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  List<Widget> plantsColumnElements(
      double width, PlantController plantController) {
    return [
      SizedBox(
        height: 68,
        child: Row(
          children: [
            Spacer(),
            AnimSearchBar(
              width: width * 0.65,
              textController: textController,
              onSuffixTap: () {
                textController.clear();
              },
              rtl: true,
              animationDurationInMilli: 300,
            ),
            SizedBox(
              width: width * 0.05,
            )
          ],
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: width * 0.1),
        child: Text(
          "Green",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: width * 0.1),
        child: Text(
          "Plants",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      for (int index = 0; index < plantController.plantList.length; index++)
        PlantCard(
          width: width,
          plant: plantController.plantList[index],
          index: index,
        ),
    ];
  }
}
