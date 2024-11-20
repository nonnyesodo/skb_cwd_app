import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skb_cwd_app/Features/UserFeatures/auth/presentation/bloc/cubit/auth_cubit.dart';
import '../../../../../../constants/appcolors.dart';
import '../../../../../../globalwidget/export.dart';
import '../../data/local/home_static_repo.dart';
import '../cubit/home_cubit.dart';
import '../widgets/app_drawer.dart';

///bootom navigation bar 
class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchHome = context.watch<HomeCubit>();
    return Scaffold(
        // key: context.watch<HomeCubit>().scaffoldKey,
        drawer: const AppDrawer(),
        body: watchHome.bottomnavScreen(
            isAdmin: context.read<AuthCubit>().user.isAdmin ??
                false)[watchHome.bottonnavIndex],
        bottomNavigationBar: AppshadowContainer(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.width * 0.03),
          height: 70.h,
          radius: 0,
          color: Appcolors.blue,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  HomeStaticRepo.bottomNavLabel.length,
                  (index) => BottomNavButtons(
                      isActive: watchHome.bottonnavIndex == index,
                      onTap: () =>
                          context.read<HomeCubit>().changeBottomNav(index),
                      size: size,
                      icon: HomeStaticRepo.bottomNavLabel[index].icon,
                      title: HomeStaticRepo.bottomNavLabel[index].label))),
        ));
  }
}

class BottomNavButtons extends StatelessWidget {
  const BottomNavButtons(
      {super.key,
      required this.size,
      this.isActive = false,
      required this.icon,
      required this.title,
      this.onTap});

  final Size size;
  final bool isActive;
  final IconData icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Icon(icon,
            size: 30.sp,
            color: isActive ? Appcolors.green : Appcolors.inActive),
        SizedBox(height: size.width * 0.001),
        AppText(
            text: title,
            color: isActive ? Appcolors.green : Appcolors.inActive,
            size: 10,
            fontweight: FontWeight.w500)
      ]),
    );
  }
}
