import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dynamic_widget_app_task/controllers/cart_controller.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return GestureDetector(
      onTap: () async {
        if (cartController.totalPrice.value != 0.0) {
          var result = await Get.defaultDialog(
            title: "Checkout",
            middleText:
                "Press confirm to buy selected plants\nTotal Prize: ${cartController.totalPrice.value} Rs",
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
            cartController.checkout();
            _sendOrderPlacedNotification();
          }
        } else {
          Get.snackbar(
            "Add Items First",
            "Cant checkout your cart is empty",
            backgroundColor: UIHelper.darkgreencolor,
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 48.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(180, 255, 180, 1.0),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 8,
              color: Colors.black26,
            )
          ],
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        child: Center(
          child: Text(
            "Check Out",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void _sendOrderPlacedNotification() async {
    var deviceState = await OneSignal.shared.getDeviceState();
    if (deviceState == null || deviceState.userId == null) return;
    var playerId = deviceState.userId!;
    var notification = OSCreateNotification(
      playerIds: [playerId],
      heading: "Order Placex",
      content: "Your Order Placed Successfully",
      // buttons: [
      //   OSActionButton(text: "test1", id: "id1"),
      // ],
      url: "PlantApp://plantapp.com/cart",
    );
    var response = await OneSignal.shared.postNotification(notification);
    print("Sent notification with response: $response");
  }
}
