import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skb_cwd_app/constants/appcolors.dart'; 

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../export.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {super.key, this.color, required this.body, this.floatingActionButton,   this.isloading=false});
  final Color? color;
  final Widget? body, floatingActionButton;

  final bool isloading;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingActionButton,
        backgroundColor: color ?? Appcolors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.h),
            child: AppBar(
                forceMaterialTransparency: true,
                automaticallyImplyLeading: false,
                backgroundColor: color ?? Appcolors.white)),
         body: Stack(
        children: [
          AbsorbPointer(
            absorbing: isloading,
            child: Opacity(opacity: isloading ? 0.2 : 1.0, child: body),
          ),
          isloading
              ? Column(
                  children: [
                    SizedBox(height: 220.h),
                    Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                            color: Appcolors.blackColor, size: 60.sp)),
                    
                    3.verticalSpace,
              const AppText(
                        text:   ' Please wait...'  ,
                        fontweight: FontWeight.w600),
                  ],
                )
              : const SizedBox.shrink()
        ],
      )  );
  }
}
