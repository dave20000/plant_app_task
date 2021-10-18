import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import 'package:dynamic_widget_app_task/controllers/base_controller.dart';
import 'package:dynamic_widget_app_task/controllers/cart_controller.dart';
import 'package:dynamic_widget_app_task/models/cart.dart';
import 'package:dynamic_widget_app_task/models/plant.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';

class PlantDetailAppBar extends StatelessWidget {
  final Plant plant;
  final RxInt quantity;
  const PlantDetailAppBar({
    Key? key,
    required this.plant,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final BaseController baseController = Get.find();
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButton(
            onPressed: () {
              Get.back();
            },
          ),
          Row(
            children: [
              LikeButton(
                circleColor: CircleColor(
                  start: UIHelper.amberColor,
                  end: UIHelper.lightgreencolor,
                ),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: UIHelper.lightgreencolor,
                  dotSecondaryColor: UIHelper.amberColor,
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? UIHelper.darkgreencolor : Colors.black,
                    size: 24,
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  if (cartController.cartProducts.isEmpty) {
                    baseController.removeOneSignalCartAbandondedTag();
                  }
                  baseController.sendItemAddedNotification();
                  cartController.addProduct(
                    Cart(
                      cartItemId: DateTime.now().millisecondsSinceEpoch,
                      quantity: quantity,
                      plant: plant,
                    ),
                  );
                  Get.snackbar(
                    "Cart Updated",
                    "Successfully Added item to the cart",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.greenAccent,
                  );
                },
                icon: Badge(
                  padding: EdgeInsets.all(4),
                  badgeColor: UIHelper.lightAmberColor,
                  stackFit: StackFit.loose,
                  badgeContent: Text(
                    "${cartController.cartProducts.length.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              ),
              SizedBox(
                width: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
