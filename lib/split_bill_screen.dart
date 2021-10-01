import 'package:flutter/material.dart';

class SplitBillScreen extends StatefulWidget {
  const SplitBillScreen({Key? key}) : super(key: key);

  @override
  _SplitBillScreenState createState() => _SplitBillScreenState();
}

class _SplitBillScreenState extends State<SplitBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(72, 66, 109, 1),
        body: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(54, 49, 86, 1),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(236, 192, 140, 1),
                  ),
                ),
                Row(
                  children: const [
                    Text(
                      "Split Now",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(236, 192, 140, 1),
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Color.fromRGBO(236, 192, 140, 1),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
