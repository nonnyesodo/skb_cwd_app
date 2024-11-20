import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/appcolors.dart';
import '../export.dart';
 

class Appbutton extends StatelessWidget {
  const Appbutton(
      {super.key,
      this.buttonColor,
      this.child,
      this.label,
      this.onTap,
      this.width,
      this.height,
      this.labelColor,
      this.isLoading = false});

  final Color? buttonColor, labelColor;
  final Widget? child;
  final String? label;
  final Function()? onTap;
  final double? width, height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AppshadowContainer(
        onTap: onTap,
        shadowcolour: Colors.transparent,
        width: width ?? size.width,
        height: height ?? size.height * 0.055,
        radius: size.width * 0.02,
        color: buttonColor ?? Appcolors.green,
        child: isLoading
            ? LoadingAnimationWidget.threeRotatingDots(
                color: Appcolors.white, size: 20.sp)
            : child ??
                AppText(
                    text: label ?? '',
                    color: labelColor ?? Appcolors.white,
                    size: 14,
                    fontweight: FontWeight.w500));
  }
}
