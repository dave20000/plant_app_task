import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget_app_task/screens/home_screen.dart';
import 'package:dynamic_widget_app_task/screens/plant_detail_screen.dart';
import 'package:dynamic_widget_app_task/widget_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/plant_detail_screen',
          page: () => PlantDetailScreen(),
        ),
      ],
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text("Dynamic Widget"),
      //   ),
      //   body: DynamicWidgetBuilder.build(
      //     columnJson,
      //     context,
      //     DefaultClickListener(),
      //   ),
      // ),
    );
  }
}

class DefaultClickListener implements ClickListener {
  @override
  void onClicked(String? event) {
    print("Receive click event: " + (event ?? ""));
  }
}
