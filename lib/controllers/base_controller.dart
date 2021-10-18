import 'package:dynamic_widget_app_task/services/one_signal_service.dart';
import 'package:get/state_manager.dart';

class BaseController extends GetxController {
  final OneSignalNotificationService oneSignalNotificationService;
  BaseController({required this.oneSignalNotificationService});

  @override
  void onInit() {
    super.onInit();
    oneSignalNotificationService.oneSignalInitialization(requireConsent: false);
  }

  void sendOrderPlacedNotification() {
    oneSignalNotificationService.sendOrderPlacedNotification();
  }

  void sendItemAddedNotification() {
    oneSignalNotificationService.sendItemAddedNotification();
  }

  void addOneSignalCardAbandonedTag() {
    oneSignalNotificationService.addOneSignalCardAbandonedTag();
  }

  void removeOneSignalCartAbandondedTag() {
    oneSignalNotificationService.removeOneSignalCartAbandondedTag();
  }
}
