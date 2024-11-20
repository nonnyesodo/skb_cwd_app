import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skb_cwd_app/Features/UserFeatures/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:skb_cwd_app/config/page%20route/detail/route_name.dart';

import '../../../../../globalwidget/export.dart'; 

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthCubit>().user;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),

            //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              accountName: AppText(text: '${user.firstName}${user.lastName}'),
              accountEmail: AppText(text: '${user.email}'),
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 25.0, color: Colors.blue),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader

          Padding(
            padding: const EdgeInsets.all(0),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          //
          ListTile(
            leading: const Icon(Icons.local_shipping),
            title: const Text(' New Shipping Order '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list_sharp),
            title: const Text(' View Orders'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const AppText(text: 'Report An Issue'),
            onTap: () {
              Navigator.pushNamed(context, RouteName.reportIssue);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart_checkout_sharp),
            title: const Text('Make Payment'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.spatial_tracking),
            title: const Text(' Tracking Shipment '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Navigator.pop(context);
            }
          ),
        ],
      ),
    );
  }
}
