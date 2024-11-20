import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skb_cwd_app/Features/AdminFeatures/admin_dasgboard/presentation/bloc/cubit/admin_cubit.dart';
import 'package:skb_cwd_app/constants/appcolors.dart';
import '../../../../../config/page route/page_route.dart';
import '../../../../../globalwidget/export.dart';
import '../../data/local/admin_static_repo.dart';



///////////Admin home page
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final readAdmin = context.read<AdminCubit>();
    return AppScaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AdminAppbar(size: size),
        40.verticalSpace,

        Expanded(
          child: GridView.count(
              crossAxisSpacing: size.width * 0.04,
              mainAxisSpacing: size.width * 0.04,
              crossAxisCount: 2,
              children: List.generate(
                  AdminStaticRepo.adminDashboard.length,
                  (index) => AppshadowContainer(
                        onTap: () {
                          Navigator.pushNamed(context,
                              AdminStaticRepo.adminDashboard[index].page ?? '');

                          if (AdminStaticRepo.adminDashboard[index].page ==
                              RouteName.adminNewShipment) {
                            readAdmin.fetchShipment(status: 'Pending');
                          } else if (AdminStaticRepo
                                  .adminDashboard[index].page ==
                              RouteName.adminApprovedShipment) {
                            readAdmin.fetchShipment(status: 'Approved');
                          }
                        },
                        color: AdminStaticRepo.adminDashboard[index].color
                            ?.withOpacity(0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppshadowContainer(
                                width: size.width * 0.1,
                                height: size.width * 0.1,
                                color: AdminStaticRepo
                                    .adminDashboard[index].color
                                    ?.withOpacity(0.5),
                                child: Icon(
                                    AdminStaticRepo.adminDashboard[index].icon,
                                    size: 25.sp,
                                    color: Appcolors.white)),
                            AppText(
                                textalign: TextAlign.center,
                                text: AdminStaticRepo
                                        .adminDashboard[index].label ??
                                    '',
                                size: 16)
                          ],
                        ),
                      ))),
        ),

        // AppshadowContainer(
        //   alignment: Alignment.centerLeft,
        //   padding: EdgeInsets.all(size.width * 0.03),
        //   shadowcolour: Appcolors.inActive,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const AppText(
        //           text: 'Daily Activities', fontweight: FontWeight.w600),
        //       5.verticalSpace,
        //       Column(
        //           children: List.generate(
        //         2,
        //         (index) => Padding(
        //           padding: EdgeInsets.only(bottom: size.width * 0.01),
        //           child: Row(
        //             children: [
        //               AppshadowContainer(
        //                   width: 10.w, height: 10.w, color: Appcolors.green),
        //               5.horizontalSpace,
        //               const AppText(text: 'Created new shipment', size: 16),
        //               const Spacer(),
        //               const AppText(text: '9:45pm', size: 16)
        //             ],
        //           ),
        //         ),
        //       )),
        //     ],
        //   ),
        // )
      ]),
    ));
  }
}

class AdminAppbar extends StatelessWidget {
  const AdminAppbar({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppshadowContainer(
              color: Appcolors.white,
              shadowcolour: Appcolors.inActive,
              padding: EdgeInsets.all(size.width * 0.03),
              onTap: () {
                // context
                //     .read<HomeCubit>()
                //     .scaffoldKey
                //     .currentState
                //     ?.openDrawer();
              },
              child: Icon(Icons.more_horiz, size: 25.sp),
            ),
            GestureDetector(
              onTap: () {
                // context
                //     .read<HomeCubit>()
                //     .scaffoldKey
                //     .currentState
                //     ?.openDrawer();
              },
              child: AppNetwokImage(
                  radius: size.width * 0.05,
                  height: size.width * 0.13,
                  width: size.width * 0.13,
                  imageUrl: ''),
            )
          ],
        ),
        10.verticalSpace,
        const AppText(text: 'Welcome Admin'),
        const AppText(
            text: 'Your DashBoard', fontweight: FontWeight.w500, size: 22),
      ],
    );
  }
}
