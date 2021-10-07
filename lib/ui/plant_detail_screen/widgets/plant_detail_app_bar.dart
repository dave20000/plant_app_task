import 'package:badges/badges.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:dynamic_widget_app_task/controllers/cart_controller.dart';
import 'package:dynamic_widget_app_task/models/cart.dart';
import 'package:dynamic_widget_app_task/models/plant.dart';

class PlantDetailAppBar extends StatelessWidget {
  final Plant plant;
  final RxInt quantity;
  const PlantDetailAppBar({
    Key? key,
    required this.plant,
    required this.quantity,
  }) : super(key: key);

  void _handleSendNotification() async {
    var deviceState = await OneSignal.shared.getDeviceState();
    if (deviceState == null || deviceState.userId == null) return;
    var playerId = deviceState.userId!;
    var notification = OSCreateNotification(
      playerIds: [playerId],
      content: "One item added to cart",
      heading: "Checkout",
      buttons: [
        OSActionButton(text: "test1", id: "id1"),
      ],
      url: "PlantApp://plantapp.com/cart",
    );
    var response = await OneSignal.shared.postNotification(notification);
    print("Sent notification with response: $response");
  }

  void removeOneSignalCartAbandondedTag() async {
    await OneSignal.shared.deleteTags(['Cart']).then((response) {
      print("Successfully delete tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
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
                    removeOneSignalCartAbandondedTag();
                  }
                  _handleSendNotification();
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
