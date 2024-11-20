import 'package:flutter/cupertino.dart';
import 'package:skb_cwd_app/Features/AdminFeatures/admin_dasgboard/presentation/pages/admin_new_shipment.dart';
import 'package:skb_cwd_app/Features/UserFeatures/home/presentation/pages/create_shipment.dart';
import '../../../Features/AdminFeatures/admin_dasgboard/presentation/pages/admin_add_user_page.dart';
import '../../../Features/AdminFeatures/admin_dasgboard/presentation/pages/admin_approve_shipment.dart';
import '../../../Features/UserFeatures/auth/presentation/pages/login_page.dart';
import '../../../Features/UserFeatures/auth/presentation/pages/register_page.dart';
import '../../../Features/UserFeatures/home/presentation/pages/bottom_nav.dart';
import '../../../Features/UserFeatures/home/presentation/pages/report_issue.dart';
import '../../../Features/UserFeatures/home/presentation/pages/shipment_document.dart';
import '../../../Features/UserFeatures/home/presentation/pages/shipment_history.dart';
import '../page_route.dart';

class AppRoute {
  static Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.bottomNav:
        return CustomPageRoute(child: const BottomNav());
      case RouteName.login:
        return CustomPageRoute(child: const LoginPage());
      case RouteName.register:
        return CustomPageRoute(child: const RegisterPage());
      case RouteName.reportIssue:
        return CustomPageRoute(child: const ReportIssue());
      case RouteName.createShipment:
        return CustomPageRoute(child: const CreateShipment());
      case RouteName.shipmentHistory:
        return CustomPageRoute(child: const UserShipmentHistory());
      case RouteName.shipmentDocumnet:
        return CustomPageRoute(child: const ShipmentDocumentPage());
      case RouteName.adminUser:
        return CustomPageRoute(child: const AdminUsers());
      case RouteName.adminNewShipment:
        return CustomPageRoute(child: const AdminNewShipment());
      case RouteName.adminApprovedShipment:
        return CustomPageRoute(child: const AdminApprovedShipment());

      default:
        return CustomPageRoute(child: const LoginPage());
    }
  }
}
