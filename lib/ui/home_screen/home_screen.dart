import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:dynamic_widget_app_task/controllers/plant_controller.dart';
import 'package:dynamic_widget_app_task/ui/home_screen/widgets/navigation_rail_plant.dart';
import 'package:dynamic_widget_app_task/ui/home_screen/widgets/plant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final textController = TextEditingController();

  bool requireConsent = false;

  @override
  void initState() {
    super.initState();
    oneSignalInit();
  }

  void oneSignalInit() {
    if (!mounted) return;
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

  @override
  Widget build(BuildContext context) {
    final PlantController plantController = Get.find();
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Row(
          children: [
            NavigationRailPlant(
              width: width,
              selectedIndex: selectedIndex,
            ),
            VerticalDivider(
              thickness: width * 0.1,
              width: width * 0.1,
              color: Colors.white,
              // color: Color.fromRGBO(255, 249, 235, 1),
            ),
            Obx(
              () => Scrollbar(
                thickness: 8,
                interactive: true,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: width * 0.75,
                    decoration: BoxDecoration(
                        //color: Color.fromRGBO(255, 249, 235, 1),
                        ),
                    child: AnimationLimiter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children:
                              plantsColumnElements(width, plantController),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> plantsColumnElements(
      double width, PlantController plantController) {
    return [
      SizedBox(
        height: 68,
        child: Row(
          children: [
            Spacer(),
            AnimSearchBar(
              width: width * 0.65,
              textController: textController,
              onSuffixTap: () {
                textController.clear();
              },
              rtl: true,
              animationDurationInMilli: 300,
            ),
            SizedBox(
              width: width * 0.05,
            )
          ],
        ),
      ),
      Text(
        "Green",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        "Plants",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 16,
      ),
      for (int index = 0; index < plantController.plantList.length; index++)
        PlantCard(
          width: width,
          plant: plantController.plantList[index],
          index: index,
        ),
    ];
  }
}
