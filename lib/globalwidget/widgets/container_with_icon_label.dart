import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/appcolors.dart';
import '../export.dart';

class ContainerWithIconAndLabel extends StatelessWidget {
  const ContainerWithIconAndLabel({
    super.key,
    required this.size,
    required this.label,
    required this.icon,
  });

  final Size size;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppshadowContainer(
      width: size.width * 0.45,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04, vertical: size.width * 0.03),
      color: const Color(0xffF1F2F3),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        AppText(text: label, size: 16, fontweight: FontWeight.w500),
        SizedBox(width: size.width * 0.02),
        Icon(icon, size: 20.sp, color: Appcolors.blackColor)
      ]),
    );
  }
}
