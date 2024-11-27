import 'package:flutter/material.dart';
import 'package:skb_cwd_app/config/page%20route/detail/route_name.dart';
import 'package:skb_cwd_app/constants/appcolors.dart';

import '../../../../AdminFeatures/admin_dashboard/data/local/admin_static_repo.dart';
import '../model/shipmennt_zone_model.dart';

class HomeStaticRepo {
  static List<BottomNavModel> bottomNavLabel = [
    BottomNavModel(icon: Icons.home, label: 'Home'),
    BottomNavModel(icon: Icons.settings, label: 'Settings'),
    BottomNavModel(icon: Icons.person, label: 'Profile'),
  ];

  static List<DashboardModel> userBoardService = [
    DashboardModel(
        icon: Icons.local_shipping,
        label: 'Shipment\nOrdered',
        page: RouteName.shipmentHistory,
        color: Appcolors.green),
    DashboardModel(
        icon: Icons.money, label: 'Make\nPayment', color: Appcolors.yellow),
    DashboardModel(
        icon: Icons.recycling, label: 'Dropped\nOff', color: Appcolors.blue),
    DashboardModel(
        icon: Icons.flight,
        label: 'New Shipment\nRequest',
        page: RouteName.createShipment,
        color: Colors.blueGrey)
  ];

  static List<ShipmentZoneModel> shipmentZOnes = [
    ShipmentZoneModel(
        destination: "London (UK)", origin: 'Ikeja (NG)', routeCode: 'NGALKJ1'),
    ShipmentZoneModel(
        destination: "Johannesburg (SA)",
        origin: 'Abuja (NG)',
        routeCode: 'NGJOH1')
  ];
}

class BottomNavModel {
  final String label;
  final IconData icon;
  final Color? color;
  BottomNavModel({required this.icon, this.color, required this.label});
}
