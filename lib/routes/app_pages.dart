import 'package:get/get.dart';

import 'package:dynamic_widget_app_task/bindings/base_binding.dart';
import 'package:dynamic_widget_app_task/bindings/cart_binding.dart';
import 'package:dynamic_widget_app_task/bindings/plants_binding.dart';
import 'package:dynamic_widget_app_task/ui/screens/cart_screen/cart_screen.dart';
import 'package:dynamic_widget_app_task/ui/screens/home_screen/home_screen.dart';
import 'package:dynamic_widget_app_task/ui/screens/plant_detail_screen/plant_detail_screen.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => HomeScreen(),
      bindings: [
        BaseBinding(),
        PlantsBinding(),
        CartBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.plantdetails,
      page: () => PlantDetailScreen(),
      bindings: [
        PlantsBinding(),
        CartBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartScreen(),
      bindings: [
        CartBinding(),
      ],
      transition: Transition.leftToRight,
    ),
  ];
}
