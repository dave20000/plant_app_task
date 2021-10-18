import 'package:dynamic_widget_app_task/routes/app_pages.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';

import 'package:dynamic_widget_app_task/models/plant.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantCard extends StatelessWidget {
  final double width;
  final Plant plant;
  final int index;
  const PlantCard({
    Key? key,
    required this.width,
    required this.plant,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.65,
      margin: EdgeInsets.only(
        bottom: 22,
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.plantdetails, arguments: {
            'id': index,
          });
        },
        child: Card(
          shadowColor: UIHelper.darkgreencolor,
          margin: EdgeInsets.all(4),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            color: UIHelper.lightgreencolor,
            height: 354,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'plantImage${plant.id.toString()}',
                  child: Container(
                    width: width * 0.65,
                    height: 240,
                    decoration: BoxDecoration(
                      color: UIHelper.lightAmberColor,
                      image: DecorationImage(
                        image: AssetImage(plant.plantAssetString),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    plant.name,
                    style: GoogleFonts.acme(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    plant.details,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade900,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    plant.prize.toString() + " Rs",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
