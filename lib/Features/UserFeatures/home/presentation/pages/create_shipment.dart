import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:skb_cwd_app/Features/UserFeatures/home/presentation/cubit/home_cubit.dart';

import '../../../../../globalwidget/export.dart';
import '../../../../AdminFeatures/admin_dashboard/presentation/pages/admin_add_user_page.dart';
import '../widgets/export_widgets.dart';

////ui for user to create shipment
class CreateShipment extends StatelessWidget {
  const CreateShipment({super.key});

  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeCubit>();
    final readHome = context.read<HomeCubit>();
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
        isloading: watchHome.state is HomeLoadingState,
        body: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeCreatedShipmentState) {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const ShipmentSummaryModalsheet();
                  });
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Column(
              children: [
                AppCustomAppBar(
                  title: 'Create Shipment',
                  ontap: () {
                    readHome.pageController.page?.toInt() == 0
                        ? Navigator.pop(context)
                        : readHome.previousVerificationStage();
                  },
                ),
                20.verticalSpace,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  VerificationCheck(
                      label: 'Shipment\nDetails',
                      isActive: watchHome.verificationStage <= 3,
                      hideDivider: false),
                  VerificationCheck(
                      label: 'Address\nDetails',
                      isActive: watchHome.verificationStage >= 1,
                      hideDivider: false),
                  VerificationCheck(
                      label: 'Shipment\nDetail',
                      isActive: watchHome.verificationStage >= 2,
                      hideDivider: true),
                ]),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: const AppText(
                      textalign: TextAlign.center,
                      size: 16,
                      height: 0,
                      text:
                          'Please enter the correct details to create your Shipment'),
                ),
                20.verticalSpace,
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: watchHome.pageController,
                        children: const [
                          ShipperDetailPage(),
                          AddressDetailPage(),
                          ShipmentItemPage(),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
