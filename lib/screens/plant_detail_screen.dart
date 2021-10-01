import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class PlantDetailScreen extends StatefulWidget {
  const PlantDetailScreen({Key? key}) : super(key: key);

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Color.fromRGBO(255, 249, 235, 1),
            ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(),
                    Row(
                      children: [
                        // LikeButton(
                        //   onTap: (bool val) {
                        //     setState(() {
                        //       isLiked = !isLiked;
                        //     });
                        //   },
                        // ),
                        LikeButton(
                          circleColor: CircleColor(
                              start: Color(0xFF1D7503), end: Color(0xFF35FF79)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xFF48E533),
                            dotSecondaryColor: Color(0xFF2BFD47),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked
                                  ? Color.fromRGBO(128, 157, 89, 1)
                                  : Colors.black,
                              size: 24,
                            );
                          },
                        ),

                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       isLiked = !isLiked;
                        //     });
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.all(8),
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Color.fromRGBO(128, 157, 89, 1),
                        //     ),
                        //     child: Icon(
                        //       Icons.favorite_border_outlined,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Hero(
                  tag: 'plantImage0',
                  child: Container(
                    height: height * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/plants-png-44906.png'),
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
                      Text(
                        "Wall Mounted Plant Glass Pothead",
                        style: GoogleFonts.acme(
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          wordSpacing: 1.4,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Plant in a glass bowl. It can be mounted on a wall or ceiling (holder included",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            "Rs 5500",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 24,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.green,
                                      blurRadius: 2.0,
                                      spreadRadius: 2,
                                    ),
                                  ]),
                              child: Icon(
                                Icons.add,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: const [
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
                          "40cm - 50cm",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
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
                          "18\u00b0C - 25\u00b0C",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
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
                          "Slef Watering Pot",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromRGBO(128, 157, 89, 1); // 118, 151, 74
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.05, size.height * 0.5, 0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
