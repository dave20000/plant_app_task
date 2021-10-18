import 'package:dynamic_widget_app_task/controllers/base_controller.dart';
import 'package:dynamic_widget_app_task/ui/widgets/side_in_animation_widget.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dynamic_widget_app_task/controllers/cart_controller.dart';
import 'package:dynamic_widget_app_task/models/cart.dart';

class CartItem extends StatelessWidget {
  final double width;
  final double height;
  final Cart cartItem;
  final int index;
  const CartItem({
    Key? key,
    required this.width,
    required this.height,
    required this.cartItem,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final BaseController baseController = Get.find();
    return SideInAnimation(
      delay: 2,
      child: Container(
        width: double.infinity,
        height: height * 0.18,
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: UIHelper.lightgreencolor,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 8,
              color: Colors.black26,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                //  Get.toNamed('/plant_detail_screen', arguments: {
                //   'id': cartItem.plant.id,
                // });
              },
              child: Container(
                width: width * 0.25,
                decoration: BoxDecoration(
                  color: UIHelper.lightAmberColor,
                  border: Border.all(
                    color: Colors.amber,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: Image.asset(cartItem.plant.plantAssetString),
              ),
            ),
            Expanded(
              child: Container(
                height: height * 0.2,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '${cartItem.plant.name}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Prize: ${cartItem.plant.prize}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (cartItem.quantity.value == 1) {
                                Get.snackbar(
                                  "item",
                                  "can not have less then 1 value",
                                );
                              } else {
                                cartController.decreaseProductQuantity(index);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: UIHelper.lightAmberColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 8,
                                    color: Colors.black26,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 22,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${cartItem.quantity.value}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              cartController.addProductQuantity(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: UIHelper.lightAmberColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 8,
                                    color: Colors.black26,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.add,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 6,
                right: 16,
              ),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: UIHelper.lightAmberColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () async {
                  var result = await Get.defaultDialog(
                    title: "Remove Item",
                    middleText: "Are you sure you want to remove this item",
                    confirm: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(103, 133, 73, 1),
                      ),
                      onPressed: () {
                        Get.back(result: true);
                      },
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    cancel: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: UIHelper.darkgreencolor,
                      ),
                      onPressed: () {
                        Get.back(result: false);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ) as bool?;
                  if (result != null && result) {
                    cartController.removeProduct(index);
                    if (cartController.cartProducts.isEmpty) {
                      //addOneSignalCardAbandonedTag();
                      baseController.addOneSignalCardAbandonedTag();
                    }
                  }
                },
                child: Icon(
                  Icons.delete_outline,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
