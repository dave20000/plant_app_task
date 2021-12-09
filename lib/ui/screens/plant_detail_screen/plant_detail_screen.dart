import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dynamic_widget_app_task/controllers/plant_controller.dart';
import 'package:dynamic_widget_app_task/ui/screens/plant_detail_screen/widgets/bottom_plant_detail.dart';
import 'package:dynamic_widget_app_task/ui/screens/plant_detail_screen/widgets/curve_painter.dart';
import 'package:dynamic_widget_app_task/ui/screens/plant_detail_screen/widgets/plant_detail_app_bar.dart';
import 'package:dynamic_widget_app_task/ui/widgets/side_in_animation_widget.dart';

class PlantDetailScreen extends StatefulWidget {
  const PlantDetailScreen({Key? key}) : super(key: key);

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  bool isLiked = false;
  int quantityCount = 1;

  @override
  Widget build(BuildContext context) {
    int plantListId = Get.arguments['id'];
    final PlantController plantController = Get.find();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: [
              // Container(
              //     //color: Color.fromRGBO(255, 249, 235, 1),
              //     //color: Colors.amberAccent.shade100,
              //     ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomPaint(
                  painter: CurvePainter(),
                  child: SizedBox(
                    height: height * 0.3,
                    width: double.infinity,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  PlantDetailAppBar(
                    plant: plantController.plantList[plantListId],
                    quantity: quantityCount.obs,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Hero(
                    tag:
                        'plantImage${plantController.plantList[plantListId].id.toString()}',
                    child: Container(
                      height: height * 0.4,
                      decoration: BoxDecoration(
                        //color: Colors.amberAccent.shade100,
                        image: DecorationImage(
                          image: AssetImage(plantController
                              .plantList[plantListId].plantAssetString),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SideInAnimation(
                          delay: 1,
                          child: Text(
                            plantController.plantList[plantListId].name,
                            style: GoogleFonts.acme(
                              textStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              wordSpacing: 1.4,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SideInAnimation(
                          delay: 2,
                          child: Text(
                            plantController.plantList[plantListId].details,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SideInAnimation(
                          delay: 2,
                          child: Row(
                            children: [
                              Text(
                                quantityCount.toString() +
                                    " * " +
                                    plantController.plantList[plantListId].prize
                                        .toString() +
                                    " Rs",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 24,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.greenAccent,
                                      blurRadius: 8.0,
                                      spreadRadius: 2,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      quantityCount++;
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SideInAnimation(
                    delay: 4,
                    child: BottomPlantDetail(plantListId: plantListId),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
