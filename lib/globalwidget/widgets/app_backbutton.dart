import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbackButton extends StatelessWidget {
  const AppbackButton({
    super.key, this.onTap,
  });
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Icon(Icons.arrow_back, size: 25.sp));
  }
}
