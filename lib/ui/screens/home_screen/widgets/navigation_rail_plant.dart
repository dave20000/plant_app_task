import 'package:badges/badges.dart';
import 'package:dynamic_widget_app_task/controllers/cart_controller.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationRailPlant extends StatelessWidget {
  final double width;
  final int selectedIndex;
  const NavigationRailPlant({
    Key? key,
    required this.width,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Stack(
      children: [
        NavigationRail(
          minWidth: width * 0.15,
          groupAlignment: -0,
          backgroundColor: UIHelper.darkgreencolor,
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            // setState(() {
            //   selectedIndex = index;
            // });
          },
          labelType: NavigationRailLabelType.all,
          leading: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Icon(
              Icons.drag_indicator,
              color: Colors.white,
            ),
          ),
          destinations: [
            buildRotatedTextRailDestination("Shape Plants"),
            buildRotatedTextRailDestination("Green Plants"),
            buildRotatedTextRailDestination("Indoor Plants"),
          ],
        ),
        Obx(
          () => Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Get.toNamed('/cart');
              },
              child: Container(
                margin: EdgeInsets.all(16),
                child: Badge(
                  badgeColor: UIHelper.lightAmberColor,
                  stackFit: StackFit.loose,
                  badgeContent: Text(
                    "${cartController.cartProducts.length.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  NavigationRailDestination buildRotatedTextRailDestination(String text) {
    return NavigationRailDestination(
      icon: SizedBox.shrink(),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
