import 'package:dynamic_widget_app_task/models/enums/animation_properties.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeInAnimation extends StatelessWidget {
  final int delay;
  final Widget child;

  const FadeInAnimation({
    Key? key,
    required this.delay,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationsProperties>()
      ..add(AnimationsProperties.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(
        AnimationsProperties.translateX,
        Tween(begin: 30.0, end: 0.0),
        Duration(milliseconds: 500),
        Curves.fastOutSlowIn,
      );

    return PlayAnimation<MultiTweenValues<AnimationsProperties>>(
      delay: Duration(milliseconds: 300 * delay),
      duration: Duration(milliseconds: 500),
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AnimationsProperties.opacity),
        child: Transform.translate(
          offset: Offset(0, value.get(AnimationsProperties.translateX)),
          child: child,
        ),
      ),
    );
  }
}
