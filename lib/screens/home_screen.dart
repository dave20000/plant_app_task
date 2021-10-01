import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slidable_bar/slidable_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  final SlidableBarController controller =
      SlidableBarController(initialStatus: true);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Row(
          children: [
            Container(
              width: width * 0.2,
              decoration: BoxDecoration(
                color: Color.fromRGBO(103, 133, 73, 1),
              ),
              child: Column(
                children: const [
                  SizedBox(
                    height: 16,
                  ),
                  Icon(
                    Icons.drag_indicator,
                    color: Colors.white,
                  ),
                  Spacer(),
                  RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      "Shape Plants",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      "Green Plants",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      "Indoor Plants",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            Container(
              width: width * 0.1,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 249, 235, 1),
              ),
            ),
            Scrollbar(
              thickness: 8,
              interactive: true,
              child: SingleChildScrollView(
                child: Container(
                  width: width * 0.7,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 249, 235, 1),
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
                        children: columnElements(width),
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

  List<Widget> columnElements(double width) {
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
      for (int index = 0; index < 6; index++) plantCard(width, index),
    ];
  }

  InkWell plantCard(double width, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed('/plant_detail_screen');
      },
      child: SizedBox(
        width: width * 0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'plantImage${index.toString()}',
              child: Container(
                width: width * 0.65,
                height: 240,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/plants-png-44906.png'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Wall Mounted Plant Glass Pothead",
              style: GoogleFonts.acme(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Plant in a glass bowl. It can be mounted on a wall or ceiling (holder included",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade900,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "450 Rs",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
