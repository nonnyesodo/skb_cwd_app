import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skb_cwd_app/Features/AdminFeatures/admin_dasgboard/presentation/bloc/cubit/admin_cubit.dart';
import 'package:skb_cwd_app/Features/AdminFeatures/admin_dasgboard/presentation/pages/admin_add_user_page.dart';
import 'package:skb_cwd_app/constants/appcolors.dart';

import 'package:skb_cwd_app/globalwidget/export.dart';

import '../../../../../constants/utils/useful_methods.dart';


///////////page to display all shipment addmin has to approved or reject

class AdminNewShipment extends StatelessWidget {
  const AdminNewShipment({super.key});

  @override
  Widget build(BuildContext context) {
    final watchAdmin = context.watch<AdminCubit>();
    final shipments = watchAdmin.pendingShipments;
    final readAdmin = context.read<AdminCubit>();
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
        isloading: watchAdmin.state is AdminLoadingState,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            children: [
              const AppCustomAppBar(title: 'New Shipments'),
              20.verticalSpace,
              const AppText(
                  text: 'Showing all Unapproved Shipments',
                  fontweight: FontWeight.w600),
              20.verticalSpace,
              Expanded(
                  child: ListView(
                      children: List.generate(
                          shipments.length,
                          (index) => AppshadowContainer(
                                margin:
                                    EdgeInsets.only(bottom: size.width * 0.03),
                                padding: EdgeInsets.all(size.width * 0.03),
                                shadowcolour:
                                    Appcolors.inActive.withOpacity(0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ShipmentInfo(
                                            title: 'Ref: ',
                                            value:
                                                '${shipments[index].shipmentReference}'),
                                        ShipmentInfo(
                                            title: 'Date: ',
                                            value: UsefulMethods.formatDate(
                                                value: shipments[index]
                                                    .shipmentDate)),
                                      ],
                                    ),
                                    5.verticalSpace,
                                    ShipmentInfo(
                                      title: 'Destination: ',
                                      value:
                                          '${shipments[index].originAddress?.city ?? ''},${shipments[index].originAddress?.country ?? ''} - ${shipments[index].destinationAddress?.city ?? ''},${shipments[index].destinationAddress?.country ?? ''}',
                                    ),
                                    5.verticalSpace,
                                    ShipmentInfo(
                                        title: 'Mode Of Shipment: ',
                                        value:
                                            shipments[index].modeOfShipment ??
                                                ''),
                                    ShipmentInfo(
                                      title: 'Package Weight: ',
                                      value:
                                          '${shipments[index].package?.weight ?? ''}kg',
                                    ),
                                    20.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Appbutton(
                                            onTap: () {
                                              readAdmin.adminRejectShipment(
                                                  shipmentId:
                                                      shipments[index].id);
                                            },
                                            buttonColor: Appcolors.redColor,
                                            label: 'Cancel',
                                            width: size.width * 0.42),
                                        Appbutton(
                                            onTap: () {
                                              readAdmin.adminAcceptShipment(
                                                  shipmentId:
                                                      shipments[index].id);
                                            },
                                            label: 'Approve',
                                            width: size.width * 0.42),
                                      ],
                                    )
                                  ],
                                ),
                              ))))
            ],
          ),
        ));
  }
}

class ShipmentInfo extends StatelessWidget {
  const ShipmentInfo({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(text: title, size: 16, fontweight: FontWeight.w500),
        AppText(text: value, size: 14),
      ],
    );
  }
}
