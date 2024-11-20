import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  final int? duration;

  CustomPageRoute(
      {required this.child,
      this.duration,
      this.direction = AxisDirection.right})
      : super(
            transitionDuration: Duration(milliseconds: duration ?? 10),
            reverseTransitionDuration: Duration(milliseconds: duration ?? 10),
            pageBuilder: (context, animation, secondaryAnimation) {
              return child;
            });

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: getRightOffset(), end: Offset.zero)
          .animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  Offset getRightOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
}
