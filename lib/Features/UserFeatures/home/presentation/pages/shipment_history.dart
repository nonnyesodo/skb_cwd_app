import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:skb_cwd_app/Features/UserFeatures/home/presentation/cubit/home_cubit.dart';
import 'package:skb_cwd_app/constants/appcolors.dart';
import 'package:skb_cwd_app/globalwidget/export.dart';
import '../../../../../constants/utils/useful_methods.dart';
import '../../../../AdminFeatures/admin_dashboard/presentation/pages/admin_add_user_page.dart';
import '../../../../AdminFeatures/admin_dashboard/presentation/pages/admin_new_shipment.dart';

////page the disply all shipment created by the user 
class UserShipmentHistory extends StatelessWidget {
  const UserShipmentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final shipments = context.watch<HomeCubit>().userShipments;
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: Column(
        children: [
          const AppCustomAppBar(title: 'Shipment History'),
          Expanded(
              child: ListView(
                  children: List.generate(
                      shipments.length,
                      (index) => AppshadowContainer(
                            padding: EdgeInsets.all(size.width * 0.03),
                            margin: EdgeInsets.only(bottom: size.width * 0.04),
                            shadowcolour: Appcolors.inActive.withOpacity(0.3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ShipmentInfo(
                                        title: 'Ref: ',
                                        value: shipments[index]
                                                .shipmentReference ??
                                            ''),
                                    ShipmentInfo(
                                        title: 'Date: ',
                                        value:
                                            '${UsefulMethods.formatDate(value: shipments[index].shipmentDate)}'),
                                  ],
                                ),
                                10.verticalSpace,
                                UserShipmentHistoryInfo(
                                  size: size,
                                  address:
                                      '${shipments[index].originAddress?.streetAddress ?? ''},${shipments[index].originAddress?.state ?? ''}',
                                  weightOrPriority:
                                      shipments[index].priorityLevel ?? '',
                                ),
                                Column(
                                    children: List.generate(
                                        5,
                                        (ind) => AppshadowContainer(
                                              margin: EdgeInsets.only(
                                                  left: size.width * 0.03,
                                                  bottom: size.width * 0.007),
                                              width: size.width * 0.008,
                                              height: size.width * 0.01,
                                              border: true,
                                              color: Appcolors.blackColor,
                                            ))),
                                UserShipmentHistoryInfo(
                                  address:
                                      '${shipments[index].destinationAddress?.streetAddress ?? ''},${shipments[index].destinationAddress?.state ?? ''}',
                                  weightOrPriority:
                                      shipments[index].status ?? '',
                                  size: size,
                                  destination: true,
                                ),
                              ],
                            ),
                          ))))
        ],
      ),
    ));
  }
}

class UserShipmentHistoryInfo extends StatelessWidget {
  const UserShipmentHistoryInfo({
    super.key,
    required this.size,
    this.destination = false,
    required this.weightOrPriority,
    required this.address,
  });

  final Size size;
  final bool destination;
  final String weightOrPriority, address;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppshadowContainer(
          radius: 500.r,
          padding: EdgeInsets.all(size.width * 0.01),
          shadowcolour: Appcolors.inActive.withOpacity(0.5),
          child: Icon(destination ? Icons.location_pin : Icons.arrow_downward,
              size: 20.sp,
              color: destination ? Appcolors.blue : Appcolors.green),
        ),
        SizedBox(
          width: size.width * 0.46,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(text: address, fontweight: FontWeight.w600),
              AppText(text: destination ? 'Destination' : 'Origin', size: 14)
            ],
          ),
        ),
        SizedBox(
          width: size.width * 0.22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                  text: destination ? 'Status' : 'Priority Level',
                  size: 14,
                  fontweight: FontWeight.w500),
              AppText(text: weightOrPriority, size: 14)
            ],
          ),
        ),
      ],
    );
  }
}
