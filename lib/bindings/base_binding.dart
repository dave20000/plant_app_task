import 'package:dynamic_widget_app_task/controllers/base_controller.dart';
import 'package:dynamic_widget_app_task/services/one_signal_service.dart';
import 'package:get/get.dart';

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BaseController>(
      BaseController(
        oneSignalNotificationService: OneSignalNotificationService(),
      ),
    );
  }
}
