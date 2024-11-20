import 'package:flutter/material.dart';

import '../../constants/appcolors.dart';

class AppshadowContainer extends StatelessWidget {
  const AppshadowContainer(
      {super.key,
      this.child,
      this.shadowcolour,
      this.color,
      this.padding,
      this.margin,
      this.width,
      this.height,
      this.radius,
      this.onTap,
      this.borderColor,
      this.border = false, this.alignment});
  final Widget? child;
  final Color? shadowcolour, color, borderColor;
  final EdgeInsetsGeometry? padding, margin;
  final double? width, height, radius;
  final Function()? onTap;
  final bool border;
  final AlignmentGeometry? alignment;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: alignment ?? Alignment.center,
            width: width,
            height: height,
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
                color: color ?? Appcolors.white,
                border: Border.all(
                    width: border ? 2.0 : 0,
                    color: borderColor ?? Colors.transparent),
                boxShadow: [
                  BoxShadow(
                      color: shadowcolour ?? Colors.transparent,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 0)
                ],
                borderRadius:
                    BorderRadius.circular(radius ?? size.width * 0.02)),
            child: child));
  }
}
