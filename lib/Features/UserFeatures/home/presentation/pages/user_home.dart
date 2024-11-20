import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skb_cwd_app/Features/UserFeatures/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:skb_cwd_app/constants/appcolors.dart';
import '../../../../../globalwidget/export.dart';
import '../../data/local/home_static_repo.dart';
import '../cubit/home_cubit.dart';


////user homepage 
class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        UserHomeDashBoard(size: size),
        20.verticalSpace,
        AppshadowContainer(
          padding: EdgeInsets.all(size.width * 0.03),
          shadowcolour: Appcolors.inActive,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  text:
                      'Welcom back ${context.watch<AuthCubit>().user.firstName ?? ''}!',
                  fontweight: FontWeight.w600),
              const AppText(
                  text:
                      'Need to make shipment order head over to shipment and create a shipment'),
            ],
          ),
        ),
        30.verticalSpace,
        const AppText(text: 'Services', fontweight: FontWeight.w500),
        10.verticalSpace,
        SizedBox(
          height: size.height * 0.47,
          child: GridView.count(
              crossAxisSpacing: size.width * 0.04,
              mainAxisSpacing: size.width * 0.04,
              crossAxisCount: 2,
              children: List.generate(
                  HomeStaticRepo.userBoardService.length,
                  (index) => AppshadowContainer(
                        onTap: () {
                          context.read<HomeCubit>().fetchUserShipments();
                          Navigator.pushNamed(
                              context,
                              HomeStaticRepo.userBoardService[index].page ??
                                  '');
                        },
                        color: HomeStaticRepo.userBoardService[index].color
                            ?.withOpacity(0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppshadowContainer(
                                width: size.width * 0.1,
                                height: size.width * 0.1,
                                color: HomeStaticRepo
                                    .userBoardService[index].color
                                    ?.withOpacity(0.5),
                                child: Icon(
                                    HomeStaticRepo.userBoardService[index].icon,
                                    size: 25.sp,
                                    color: Appcolors.white)),
                            AppText(
                                textalign: TextAlign.center,
                                text: HomeStaticRepo
                                        .userBoardService[index].label ??
                                    '',
                                size: 16)
                          ],
                        ),
                      ))),
        ),
        AppshadowContainer(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(size.width * 0.03),
          shadowcolour: Appcolors.inActive,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                  text: 'Daily Activities', fontweight: FontWeight.w600),
              5.verticalSpace,
              Column(
                  children: List.generate(
                2,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: size.width * 0.01),
                  child: Row(
                    children: [
                      AppshadowContainer(
                          width: 10.w, height: 10.w, color: Appcolors.green),
                      5.horizontalSpace,
                      const AppText(text: 'Created new shipment', size: 16),
                      const Spacer(),
                      const AppText(text: '9:45pm', size: 16)
                    ],
                  ),
                ),
              )),
            ],
          ),
        )
      ]),
    ));
  }
}

class UserHomeDashBoard extends StatelessWidget {
  const UserHomeDashBoard({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                // context
                //     .read<HomeCubit>()
                //     .scaffoldKey
                //     .currentState
                //     ?.openDrawer();
              },
              child: Icon(
                Icons.more_horiz,
                size: 25.sp,
              ),
            ),
            const AppText(
                text: 'DashBoard', fontweight: FontWeight.w500, size: 22),
          ],
        ),
        Row(
          children: [
            Icon(Icons.notifications, size: 25.sp),
            GestureDetector(
              onTap: () {
                // context
                //     .read<HomeCubit>()
                //     .scaffoldKey
                //     .currentState
                //     ?.openDrawer();
              },
              child: AppNetwokImage(
                  radius: size.width * 0.1,
                  height: size.width * 0.1,
                  width: size.width * 0.1,
                  imageUrl: ''),
            )
          ],
        ),
      ],
    );
  }
}
