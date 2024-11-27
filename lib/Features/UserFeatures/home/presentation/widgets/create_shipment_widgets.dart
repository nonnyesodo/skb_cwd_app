import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';
import 'package:skb_cwd_app/constants/utils/auth_validator.dart';
import '../../../../../config/page route/page_route.dart';
import '../../../../../constants/appcolors.dart';
import '../../../../../constants/utils/useful_methods.dart';
import '../../../../../globalwidget/export.dart';
import '../../../../AdminFeatures/admin_dashboard/presentation/pages/admin_new_shipment.dart';
import '../../../auth/presentation/bloc/cubit/auth_cubit.dart';
import '../../data/local/home_static_repo.dart';
import '../cubit/home_cubit.dart';

class ShipmentSummaryModalsheet extends StatelessWidget {
  const ShipmentSummaryModalsheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeCubit>();
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ShipmentConfirmedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.bottomNav, (route) => false);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText(
              text: 'Shipment Summary',
              fontweight: FontWeight.w600,
            ),
            const Divider(),
            ShipmentInfo(
                title: 'origin: ',
                value: "${watchHome.userAddress.text},${watchHome.userCity}"),
            10.verticalSpace,
            ShipmentInfo(
                title: 'destination: ',
                value:
                    " ${watchHome.receiverAddress.text},${watchHome.receiverCity}"),
            10.verticalSpace,
            ShipmentInfo(
                title: 'weight: ', value: "${watchHome.weight.text}KG"),
            10.verticalSpace,
            ShipmentInfo(
                title: 'EstimatedDeliveryDate: ',
                value: watchHome.estimatedDeliveryDate),
            10.verticalSpace,
            ShipmentInfo(title: 'Total:', value: watchHome.totalCost),
            10.verticalSpace,
            Row(
              children: [
                AppCheckbox(
                  status: watchHome.terms,
                  ontap: () {
                    watchHome.terms = !watchHome.terms;
                    context.read<HomeCubit>().changeState();
                  },
                ),
                5.horizontalSpace,
                const AppText(
                  text: 'Aggree to Terms And condition',
                  size: 16,
                )
              ],
            ),
            20.verticalSpace,
            Appbutton(
              isLoading: watchHome.state is HomeLoadingState,
              label: 'Confirm Shipment',
              onTap: () {
                context.read<HomeCubit>().confirmShipments();
              },
            )
          ],
        ),
      ),
    );
  }
}

class VerificationCheck extends StatelessWidget {
  const VerificationCheck({
    super.key,
    required this.label,
    required this.isActive,
    required this.hideDivider,
  });
  final String label;
  final bool isActive, hideDivider;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle,
                size: 25.sp,
                color:
                    isActive ? Appcolors.blackColor : const Color(0XFFC3C3C3)),
            hideDivider
                ? const SizedBox.shrink()
                : SizedBox(
                    width: 70.w,
                    child: Divider(
                        color: isActive
                            ? Appcolors.blackColor
                            : const Color(0XFFC3C3C3)))
          ],
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: 80.w,
          child: AppText(
              text: label,
              maxline: 2,
              color: isActive ? Appcolors.blackColor : const Color(0XFFC3C3C3),
              size: 12,
              fontweight: FontWeight.w700),
        )
      ],
    );
  }
}

class ShipperDetailPage extends StatefulWidget {
  const ShipperDetailPage({super.key});

  @override
  State<ShipperDetailPage> createState() => _ShipperDetailPageState();
}

class _ShipperDetailPageState extends State<ShipperDetailPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeCubit>();
    final readHome = context.read<HomeCubit>();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DropdownWidget(
                values: HomeStaticRepo.shipmentZOnes
                    .map((e) => e.origin ?? '')
                    .toList(),
                onSelected: (value) {
                  watchHome.originZone = value ?? '';
                  readHome.changeState();
                },
                title: 'Origin Zone',
                validator: (v) => (v!.isEmpty) ? 'select origin Zone' : null,
                prefixIcon: Icons.location_pin,
                hintText: watchHome.originZone == ''
                    ? "Select OriginZone"
                    : watchHome.originZone),
            20.verticalSpace,
            watchHome.originZone != ''
                ? DropdownWidget(
                    values: HomeStaticRepo.shipmentZOnes
                        .where((e) =>
                            e.origin.toString() ==
                            watchHome.originZone.toString())
                        .map((zone) => zone.destination ?? '')
                        .toList(),
                    validator: (v) =>
                        (v!.isEmpty) ? 'select destination Zone' : null,
                    onSelected: (value) {
                      watchHome.destinationZone = value ?? '';
                      readHome.changeState();
                    },
                    title: 'Destination Zone',
                    prefixIcon: Icons.location_pin,
                    hintText: watchHome.destinationZone == ''
                        ? "Select Destination"
                        : watchHome.destinationZone)
                : const SizedBox.shrink(),
            20.verticalSpace,
            DropdownWidget(
                values: const [
                  'Air Consolidation',
                  'Sea Freight (LCL)',
                  'Inland',
                  'Door to Airport',
                  'Door to Seaport',
                  'Door to Door'
                ],
                onSelected: (value) {
                  watchHome.shipmentMode = value ?? '';
                  readHome.changeState();
                  log(value.toString());
                },
                validator: (v) =>
                    (v!.isEmpty) ? 'select Mode of Shipment' : null,
                title: 'Mode of Shipment',
                prefixIcon: Icons.local_car_wash,
                hintText: watchHome.shipmentMode),
            20.verticalSpace,
            DropdownWidget(
                values: const [
                  'Fragile Goods',
                ],
                onSelected: (value) {
                  watchHome.typesOfGoods = value ?? '';
                  readHome.changeState();
                },
                title: 'Type of Goods',
                validator: (v) => (watchHome.typesOfGoods == '')
                    ? 'select type of goods'
                    : null,
                prefixIcon: Icons.local_car_wash,
                hintText: watchHome.typesOfGoods),
            20.verticalSpace,
            ApptextField(
                controller: watchHome.shipmentContent,
                title: 'Cargo Description',
                hintText: ' Short description of the items being shipped',
                prefixIcon: Icons.assignment,
                validator: (v) =>
                    (v!.isEmpty) ? 'select cargo description' : null,
                onChange: (p0) {
                  readHome.changeState();
                }),
            30.verticalSpace,
            Appbutton(
                label: 'Next',
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<HomeCubit>().nextVerificationStage();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class AddressDetailPage extends StatelessWidget {
  const AddressDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeCubit>();
    final readHome = context.read<HomeCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          20.verticalSpace,
          ApptextField(
            controller: watchHome.receiverName,
            title: 'Origin Address',
            prefixIcon: Icons.location_pin,
            onChange: (p0) {
              readHome.changeState();
            },
          ),
          20.verticalSpace,
          ApptextField(
              controller: watchHome.receiverAddress,
              title: 'Destination Address',
              prefixIcon: Icons.location_pin,
              onChange: (p0) {
                readHome.changeState();
              }),
          20.verticalSpace,
          DropdownWidget(
              values: const [
                'Real Gate Press',
              ],
              onSelected: (value) {
                watchHome.shipmentMode = value ?? '';
                readHome.changeState();
                log(value.toString());
              },
              title: 'Drop-Off Point',
              prefixIcon: Icons.local_car_wash,
              hintText: watchHome.shipmentMode),
          20.verticalSpace,
          ApptextField(
              // controller: watchHome.recieverPostalCode,
              title: 'Agent Code',
              onChange: (p0) {
                readHome.changeState();
              }),
          20.verticalSpace,
          30.verticalSpace,
          Appbutton(
              label: 'Next',
              onTap: () {
                context.read<HomeCubit>().nextVerificationStage();
              }),
          30.verticalSpace,
        ],
      ),
    );
  }
}

class ShipmentItemPage extends StatelessWidget {
  const ShipmentItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final watchHome = context.watch<HomeCubit>();
    final readHome = context.read<HomeCubit>();
    final user = context.read<AuthCubit>().user;
    final size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          20.verticalSpace,
          ApptextField(
              controller: watchHome.numberOfPackages,
              title: 'Item Description',
              hintText: 'item description',
              prefixIcon: Icons.numbers,
              onChange: (p0) {
                readHome.changeState();
              }),
          20.verticalSpace,
          ApptextField(
              controller: watchHome.numberOfPackages,
              title: 'Quantity',
              hintText: 'Number Of items',
              prefixIcon: Icons.numbers,
              onChange: (p0) {
                readHome.changeState();
              }),
          20.verticalSpace,
          ApptextField(
              controller: watchHome.weight,
              title: 'Weight(If known or appoximate)KG',
              prefixIcon: Icons.monitor_weight,
              onChange: (p0) {
                readHome.changeState();
              }),
          20.verticalSpace,
          ApptextField(
              controller: watchHome.height,
              title: 'Dimension height (CM)',
              onChange: (p0) {
                readHome.changeState();
              },
              prefixIcon: Icons.height),
          20.verticalSpace,
          ApptextField(
              controller: watchHome.height,
              title: 'Dimension length (CM)',
              onChange: (p0) {
                readHome.changeState();
              },
              prefixIcon: Icons.height),
          20.verticalSpace,
          ApptextField(
              controller: watchHome.height,
              title: 'Dimension Width (CM)',
              onChange: (p0) {
                readHome.changeState();
              },
              prefixIcon: Icons.height),
          20.verticalSpace,
          ApptextField(
              controller: watchHome.shipmentValue,
              title: 'Declared Value',
              hintText: 'Amount',
              prefixIcon: Icons.money_sharp,
              onChange: (p0) {
                readHome.changeState();
              }),
          20.verticalSpace,
          ApptextField(
              controller: watchHome.shipmentValue,
              title: 'Remarks',
              hintText: 'Enter remarks',
              prefixIcon: Icons.comment,
              onChange: (p0) {
                readHome.changeState();
              }),
          20.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCheckbox(
                status: watchHome.fragile,
                ontap: () {
                  readHome.fragile = !readHome.fragile;
                  readHome.changeState();
                },
              ),
              10.horizontalSpace,
              SizedBox(
                width: size.width * 0.78,
                child: const AppText(
                    height: 0,
                    maxline: 5,
                    text:
                        'I hereby declare that the information given above are accurate to the best of my knowledge and the shipment is safe for transportation, that it has no narcotics and banned substance either at  origin or destination also that the shiper are authourized to ship on our behalf',
                    size: 14),
              ),
            ],
          ),
          30.verticalSpace,
          Appbutton(
              label: 'Next',
              onTap: () {
                if (readHome.weight.text.trim().isNotEmpty &&
                    readHome.height.text.trim().isNotEmpty &&
                    readHome.width.text.trim().isNotEmpty &&
                    readHome.shipmentValue.text.trim().isNotEmpty &&
                    readHome.numberOfPackages.text.trim().isNotEmpty &&
                    readHome.shipmentContent.text.trim().isNotEmpty &&
                    readHome.shipmentMode != '' &&
                    readHome.priorityLevel != '' &&
                    readHome.carrier != '' &&
                    readHome.shippingMethod != '' &&
                    readHome.packageDescription != '') {
                  if (readHome.userCountry != readHome.recieverCountry) {
                    Navigator.pushNamed(context, RouteName.shipmentDocumnet);
                  } else {
                    log("here");
                    readHome.createUserShipments(
                        userEmail: user.email,
                        userMobile: user.mobileNmuber,
                        userName: '${user.firstName} ${user.lastName}');
                  }
                } else {
                  log("not valid");
                }
              }),
          30.verticalSpace,
        ],
      ),
    );
  }
}
