import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:dynamic_widget_app_task/routes/app_pages.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: UIHelper.darkgreencolor,
    statusBarColor: UIHelper.darkgreencolor,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppPages.pages,
      defaultTransition: Transition.fade,
    );
  }
}
