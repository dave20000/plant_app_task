import 'dart:ui';

import 'package:dynamic_widget_app_task/ui/cart_screen/widgets/check_out_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dynamic_widget_app_task/controllers/cart_controller.dart';
import 'package:dynamic_widget_app_task/ui/cart_screen/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx(
      () => SafeArea(
        child: Scaffold(
          //backgroundColor: Color.fromRGBO(255, 249, 235, 1),
          body: Column(
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
                          cartItem: cartController.cartProducts[index].value,
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
              CheckOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
