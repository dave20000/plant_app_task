import 'package:get/get.dart';

import 'package:dynamic_widget_app_task/controllers/cart_controller.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}
