import 'package:flutter/material.dart';

import '../../../../UserFeatures/home/data/local/home_static_repo.dart';
import '../../../../../config/page route/page_route.dart';
import '../../../../../constants/appcolors.dart';

class AdminStaticRepo {
  //bottom nav static datass
  static List<BottomNavModel> bottomNavLabel = [
    BottomNavModel(icon: Icons.home, label: 'Home'),
    BottomNavModel(icon: Icons.settings, label: 'Settings'),
    BottomNavModel(icon: Icons.person, label: 'Profile'),
  ];

///dashboard static data
  static List<DashboardModel> adminDashboard = [
    DashboardModel(
        icon: Icons.local_shipping, label: 'Agents', color: Appcolors.green),
    DashboardModel(
        icon: Icons.money,
        label: 'Users',
        color: Appcolors.yellow,
        page: RouteName.adminUser),
    DashboardModel(
        icon: Icons.recycling, label: 'Dropped\nOff', color: Appcolors.blue),
    DashboardModel(
        icon: Icons.flight,
        label: 'New\nOrders',
        color: Colors.blueGrey,
        page: RouteName.adminNewShipment),
    DashboardModel(
        icon: Icons.flight,
        label: 'Approved\nOrders',
        color: Colors.blueGrey,
        page: RouteName.adminApprovedShipment),
    DashboardModel(
        icon: Icons.flight, label: 'Pending\nPayments', color: Colors.blueGrey),
  ];
}

////dashboard model
class DashboardModel {
  final String? label, page;
  final IconData icon;
  final Color? color;
  DashboardModel(
      {required this.icon, this.color, this.page, required this.label});
}
