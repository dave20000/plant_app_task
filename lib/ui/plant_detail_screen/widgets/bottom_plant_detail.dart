import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dynamic_widget_app_task/controllers/plant_controller.dart';

class BottomPlantDetail extends StatelessWidget {
  final int plantListId;
  const BottomPlantDetail({
    Key? key,
    required this.plantListId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlantController plantController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            ImageIcon(
              AssetImage('assets/height.png'),
              size: 32,
              color: Colors.white,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Height",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "${plantController.plantList[plantListId].minHeight.toString()}cm - ${plantController.plantList[plantListId].maxHeight.toString()}cm",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Column(
          children: [
            ImageIcon(
              AssetImage('assets/celsius.png'),
              size: 32,
              color: Colors.white,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Temparature",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "${plantController.plantList[plantListId].minTemprature.toString()}\u00b0C - ${plantController.plantList[plantListId].maxTemprature.toString()}\u00b0C",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Column(
          children: [
            ImageIcon(
              AssetImage('assets/plant-pot.png'),
              size: 32,
              color: Colors.white,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Pot",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              plantController.plantList[plantListId].potType,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
