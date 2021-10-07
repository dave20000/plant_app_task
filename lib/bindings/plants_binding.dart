import 'package:get/get.dart';

import 'package:dynamic_widget_app_task/controllers/plant_controller.dart';

class PlantsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlantController>(() => PlantController());
  }
}
