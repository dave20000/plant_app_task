import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalNotificationService {
  void oneSignalInitialization({required bool requireConsent}) {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setRequiresUserPrivacyConsent(requireConsent);
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) async {
      //Get.snackbar('Hi', 'i am a snackbar from notification foreground');
      event.complete(event.notification);
      //notificationLaunchUrlHandler(event.notification);
    });
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      notificationLaunchUrlHandler(result.notification);
    });
    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });
    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges changes) {
      print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    });
    OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared.setAppId("c72b79ee-7672-4b82-8ed3-ef6bcdbf2540");
  }

  void notificationLaunchUrlHandler(OSNotification notification) {
    print(
      "Opened notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}",
    );
    String? link = notification.launchUrl;
    if (link != null) {
      print("LINK IS $link");
      String parse = link.replaceFirst("PlantApp://plantapp.com/", "");
      print("AFTER PARSE IS $parse");
      if (parse.isNotEmpty) {
        Get.toNamed('/$parse');
      }
    }
  }

  void sendOrderPlacedNotification() async {
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

  void addOneSignalCardAbandonedTag() async {
    OneSignal.shared.sendTags({'Cart': 'cleared'}).then((response) {
      print("Successfully sent tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
    // after 4-5 hour cart abandoned automated notification will come
  }

  void sendItemAddedNotification() async {
    var deviceState = await OneSignal.shared.getDeviceState();
    if (deviceState == null || deviceState.userId == null) return;
    var playerId = deviceState.userId!;
    var notification = OSCreateNotification(
      playerIds: [playerId],
      content: "One item added to cart",
      heading: "Checkout",
      buttons: [
        OSActionButton(text: "Go to cart", id: "cart"),
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
}
