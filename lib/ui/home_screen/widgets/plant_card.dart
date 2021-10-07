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
    return InkWell(
      onTap: () {
        Get.toNamed('/plant_detail_screen', arguments: {
          'id': index,
        });
      },
      child: Column(
        children: [
          Container(
            width: width * 0.65,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              //border: Border.all(),
              borderRadius: BorderRadius.circular(12),
              // color: Color.fromRGBO(255, 249, 235, 1),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(2, 0),
                  blurRadius: 1,
                  color: Colors.black12,
                )
              ],
            ),
            child: Container(
              color: UIHelper.lightgreencolor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
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
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      plant.details,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade900,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        plant.prize.toString() + " Rs",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
