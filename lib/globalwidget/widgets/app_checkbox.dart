import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/appcolors.dart';

class AppCheckbox extends StatelessWidget {
  final bool status;
  final double? width, height, radius;
  final Function()? ontap;

  const AppCheckbox(
      {super.key,
      required this.status,
      this.width,
      this.height,
      this.radius,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width ?? 30.w,
        height: height ?? 30.w,
        decoration: BoxDecoration(
          border: Border.all(color: Appcolors.blue),
          color: status ? Appcolors.blue : Appcolors.white,
          borderRadius: BorderRadius.circular(radius ?? 5.r),
        ),
        child: Icon(
          Icons.done,
          color: Appcolors.white,
        ),
      ),
    );
  }
}
