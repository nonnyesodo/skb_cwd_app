import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:skb_cwd_app/constants/appcolors.dart';
import 'package:skb_cwd_app/globalwidget/export.dart';

import '../../../../../constants/utils/useful_methods.dart';
import '../bloc/cubit/admin_cubit.dart';
import 'admin_add_user_page.dart';
import 'admin_new_shipment.dart';

///////////page to display all shipment addmin has approved  
class AdminApprovedShipment extends StatelessWidget {
  const AdminApprovedShipment({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final shipments = context.watch<AdminCubit>().approvedShipments;
    return AppScaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: Column(
        children: [
          const AppCustomAppBar(title: 'Approved Shipments'),
          20.verticalSpace,
          const AppText(
              text: 'Showing all Approved Shipments',
              fontweight: FontWeight.w600),
          20.verticalSpace,
          Expanded(
              child: ListView(
                  children: List.generate(
                      shipments.length,
                      (index) => AppshadowContainer(
                            margin: EdgeInsets.only(bottom: size.width * 0.03),
                            padding: EdgeInsets.all(size.width * 0.03),
                            shadowcolour: Appcolors.inActive.withOpacity(0.5),
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
                                            value:
                                                shipments[index].shipmentDate)),
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
                                        shipments[index].modeOfShipment ?? ''),
                                ShipmentInfo(
                                  title: 'Package Weight: ',
                                  value:
                                      '${shipments[index].package?.weight ?? ''}kg',
                                ),
                              ],
                            ),
                          ))))
        ],
      ),
    ));
  }
}
