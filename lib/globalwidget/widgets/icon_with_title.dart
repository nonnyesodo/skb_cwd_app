import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/appcolors.dart';
import '../export.dart';
 

class IconWithTitle extends StatelessWidget {
  const IconWithTitle(
      {super.key,
      required this.icon,
      required this.title,
      this.showDivider = true,
      this.titleColor,
      this.iconColor,
      this.onTap});
  final IconData icon;
  final String title;
  final bool showDivider;
  final Color? titleColor, iconColor;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                    text: title,
                    size: 16,
                    color: titleColor ?? Appcolors.blackColor),
                Icon(icon,
                    size: 25.sp, color: iconColor ?? Appcolors.blackColor)
              ],
            ),
          ),
          Visibility(
              visible: showDivider,
              child: Divider(color: Appcolors.inActive.withOpacity(0.5)))
        ],
      ),
    );
  }
}
