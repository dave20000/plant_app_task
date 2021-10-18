import 'package:dynamic_widget_app_task/routes/app_pages.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

class CheckOutStaggerAnimation extends StatelessWidget {
  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;
  final Animation buttomZoomOut;

  CheckOutStaggerAnimation({Key? key, required this.buttonController})
      : buttonSqueezeanimation = Tween(
          begin: 320.0,
          end: 70.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        buttomZoomOut = Tween(
          begin: 70.0,
          end: 1000.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.550,
              0.999,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: EdgeInsets.only(bottom: 50.0),
          end: EdgeInsets.only(bottom: 0.0),
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.500,
              0.800,
              curve: Curves.bounceInOut,
            ),
          ),
        ),
        super(key: key);

  Future _playAnimation() async {
    await buttonController.forward();
    await buttonController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        Get.toNamed(AppRoutes.initial);
        Get.snackbar(
          "Order Successfull",
          "Order placed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: UIHelper.lightAmberColor,
        );
      }
    });
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return buttomZoomOut.value <= 300
        ? Padding(
            padding: buttomZoomOut.value == 70
                ? EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  )
                : containerCircleAnimation.value,
            child: InkWell(
              onTap: () {
                _playAnimation();
              },
              child: Container(
                width: buttomZoomOut.value == 70
                    ? buttonSqueezeanimation.value
                    : buttomZoomOut.value,
                height: 48.0,
                alignment: FractionalOffset.center,
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
                child: buttonSqueezeanimation.value > 75.0
                    ? Text(
                        "Check Out",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )
                    : buttomZoomOut.value < 300.0
                        ? CircularProgressIndicator(
                            value: null,
                            strokeWidth: 1.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : null,
              ),
            ),
          )
        : Container(
            width: buttomZoomOut.value,
            height: buttomZoomOut.value,
            decoration: BoxDecoration(
              shape: buttomZoomOut.value < 500
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              color: Color.fromRGBO(180, 255, 180, 1.0),
            ),
            child: buttomZoomOut.value == 500
                ? Text(
                    "Order Successful",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                    ),
                  )
                : null,
          );
  }
}
