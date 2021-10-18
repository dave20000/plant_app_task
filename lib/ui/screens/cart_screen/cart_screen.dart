import 'dart:ui';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dynamic_widget_app_task/controllers/base_controller.dart';
import 'package:dynamic_widget_app_task/controllers/cart_controller.dart';
import 'package:dynamic_widget_app_task/ui/screens/cart_screen/widgets/cart_item.dart';
import 'package:dynamic_widget_app_task/ui/screens/cart_screen/widgets/check_out_button.dart';
import 'package:dynamic_widget_app_task/ui/screens/cart_screen/widgets/checkout_stagger_animation.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  late AnimationController checkOutButtonController;
  var checkOutAnimationStatus = 0;
  @override
  void initState() {
    super.initState();
    checkOutButtonController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    checkOutButtonController.dispose();
    super.dispose();
  }

  Future _playAnimation() async {
    try {
      await checkOutButtonController.forward();
      await checkOutButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final BaseController baseController = Get.find();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx(
      () => SafeArea(
        child: Scaffold(
          //backgroundColor: Color.fromRGBO(255, 249, 235, 1),
          body: Stack(
            children: [
              SizedBox(
                height: Get.height - 96,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BackButton(
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "My Cart",
                            style: TextStyle(
                              fontSize: 24,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "${cartController.cartProducts.length} Items",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: cartController.cartProducts.isEmpty
                          ? Center(
                              child: Text(
                                "Hey your cart is empty",
                                style: GoogleFonts.acme(
                                  textStyle: TextStyle(
                                    fontSize: 28,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: cartController.cartProducts.length,
                              itemBuilder: (context, index) => CartItem(
                                width: width,
                                height: height,
                                cartItem:
                                    cartController.cartProducts[index].value,
                                index: index,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total : Rs ${cartController.totalPrice.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    //CheckOutButton(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: checkOutAnimationStatus == 0
                    ? BouncingWidget(
                        onPressed: () async {
                          if (cartController.totalPrice.value != 0.0) {
                            setState(() {
                              checkOutAnimationStatus = 1;
                            });
                            _playAnimation();
                            Future.delayed(Duration(seconds: 1), () {
                              cartController.checkout();
                              baseController.sendOrderPlacedNotification();
                            });
                          } else {
                            Get.snackbar(
                              "Add Items First",
                              "Cant checkout your cart is empty",
                              backgroundColor: UIHelper.lightAmberColor,
                            );
                          }
                        },
                        child: CheckOutButton(),
                      )
                    : CheckOutStaggerAnimation(
                        buttonController: checkOutButtonController,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
