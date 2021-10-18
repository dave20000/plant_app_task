import 'dart:math';
import 'dart:ui';

import 'package:dynamic_widget_app_task/controllers/cart_controller.dart';
import 'package:dynamic_widget_app_task/models/plant.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemBottomSheet extends StatefulWidget {
  const CartItemBottomSheet({Key? key}) : super(key: key);

  @override
  _CartItemBottomSheetState createState() => _CartItemBottomSheetState();
}

class _CartItemBottomSheetState extends State<CartItemBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;
  //late Animation sheetExpandAnimation;

  double maxScreenHeight = Get.height / 1.5;

  @override
  void initState() {
    super.initState();
    bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
    );
    //? We can use this instead of lerp here
    // sheetExpandAnimation = Tween(
    //   begin: UIHelper.minCartItemBottomSheetHeight,
    //   end: maxScreenHeight,
    // ).animate(
    //   CurvedAnimation(
    //     parent: bottomSheetAnimationController,
    //     curve: Interval(
    //       0.0,
    //       1.0,
    //     ),
    //   ),
    // );
  }

  double? lerp(double min, double max) =>
      lerpDouble(min, max, bottomSheetAnimationController.value);

  @override
  void dispose() {
    bottomSheetAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return AnimatedBuilder(
      animation: bottomSheetAnimationController,
      builder: (context, _) {
        return Positioned(
          height: lerp(
            UIHelper.minCartItemBottomSheetHeight,
            maxScreenHeight,
          ),
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: toggleView,
            onVerticalDragUpdate: handleDragUpdate,
            onVerticalDragEnd: handleDragEnd,
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: UIHelper.bottomSheetColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Obx(
                () => Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      // left: lerp(16, 16 + MediaQuery.of(context).padding.top),
                      // top: lerp(16, 16 + MediaQuery.of(context).padding.top),
                      child: Padding(
                        padding: EdgeInsets.all(lerp(8, 16)!),
                        child: Text(
                          "Cart Items",
                          style: TextStyle(
                            fontSize: lerp(16, 26),
                          ),
                        ),
                      ),
                    ),
                    for (int index = 0;
                        index < (cartController.cartProducts.length);
                        index++)
                      _buildIcon(
                        cartController.cartProducts[index].value.plant,
                        index,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(Plant plant, int index) {
    return Positioned(
      top: iconTopMargin(index),
      left: iconLeftMargin(index),
      child: Container(
        height: lerp(48, 128),
        width: lerp(48, 128),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(12),
            right: Radius.circular(12),
          ),
          border: Border.all(),
        ),
        child: Image.asset(
          plant.plantAssetString,
          fit: BoxFit.fill,
          alignment: Alignment(lerp(1, 0)!, 0),
        ),
      ),
    );
  }

  double iconTopMargin(int index) =>
      lerp(16 + 8, 18 + index * (24 + 128))! + 12;

  double iconLeftMargin(int index) => lerp(12 + index * (16 + 44), 12)!;

  void toggleView() {
    final bool isFullView =
        bottomSheetAnimationController.status == AnimationStatus.completed;
    bottomSheetAnimationController.fling(
      velocity: isFullView ? -2 : 2,
      animationBehavior: AnimationBehavior.normal,
    );
  }

  void handleDragUpdate(DragUpdateDetails dragUpdateDetails) {
    bottomSheetAnimationController.value -=
        dragUpdateDetails.primaryDelta! / maxScreenHeight;
  }

  void handleDragEnd(DragEndDetails dragEndDetails) {
    if (bottomSheetAnimationController.isAnimating ||
        bottomSheetAnimationController.status == AnimationStatus.completed) {
      return;
    }
    final double flingVelocity =
        dragEndDetails.velocity.pixelsPerSecond.dy / maxScreenHeight;
    if (flingVelocity < 0.0) {
      bottomSheetAnimationController.fling(
        velocity: max(2.0, -flingVelocity),
      );
    } else if (flingVelocity > 0.0) {
      bottomSheetAnimationController.fling(
        velocity: min(-2.0, -flingVelocity),
      );
    } else {
      bottomSheetAnimationController.fling(
        velocity: bottomSheetAnimationController.value < 0.5 ? -2.0 : 2,
      );
    }
  }
}
