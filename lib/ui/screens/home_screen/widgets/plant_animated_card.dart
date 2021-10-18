import 'package:dynamic_widget_app_task/models/plant.dart';
import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class PlantAnimatedCard extends StatefulWidget {
  final double width;
  final Plant plant;
  final int index;
  const PlantAnimatedCard({
    Key? key,
    required this.width,
    required this.plant,
    required this.index,
  }) : super(key: key);

  @override
  _PlantAnimatedCardState createState() => _PlantAnimatedCardState();
}

class _PlantAnimatedCardState extends State<PlantAnimatedCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? widget.width * 0.65 : widget.width * 0.5,
            height: isExpanded ? 240 : 300,
            child:
                isExpanded ? expandedContentWidget(widget.plant) : SizedBox(),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: () {},
              child: imageWidget(widget.plant),
            ),
          ),
        ],
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }

  Widget imageWidget(Plant plant) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: size.height * 0.5,
          width: size.width * 0.65,
          child: Container(
            decoration: BoxDecoration(
              color: UIHelper.lightAmberColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: SizedBox.expand(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child:
                    Image.asset(plant.plantAssetString, fit: BoxFit.fitHeight),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(plant.name),
        ),
      ],
    );
  }

  Widget expandedContentWidget(Plant plant) {
    return Container(
      decoration: BoxDecoration(
        color: UIHelper.lightgreencolor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(plant.name),
          SizedBox(height: 8),
          Text(plant.details),
          SizedBox(height: 8),
          Text(plant.prize.toString()),
        ],
      ),
    );
  }
}
