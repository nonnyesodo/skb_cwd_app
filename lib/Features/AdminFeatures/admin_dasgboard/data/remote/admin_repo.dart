import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import '../../../../../constants/api_constants.dart';

class AdminRepo {
  /////making api request to create user by admin
  Future<Response> adminCreateUser(
      {firstName, lastName, email, mobileNumber}) async {
    var body = {
      "isAdmin": false,
      "email": email,
      "first_name": firstName,
      "mobile_number": mobileNumber,
      "last_name": lastName,
      // "fcmToken": PushNotificationHelper.fcmToken
    };
    return await post(Uri.parse(ApiConstants.adminCreateUserUrl),
        headers: ApiHeaders.aunthenticatedHeader, body: jsonEncode(body));
  }
 /////making api request to get  shipment by admin
  Future<Response> fetchShipments({status}) async {
    log(ApiConstants.adminShipmentUrl(status).toString());
    return await get(Uri.parse(ApiConstants.adminShipmentUrl(status)),
        headers: ApiHeaders.aunthenticatedHeader);
  }
 /////making api request to get all user by admin
  Future<Response> adminGetUsers() async {
    return await get(Uri.parse(ApiConstants.adminCreateUserUrl),
        headers: ApiHeaders.aunthenticatedHeader);
  }
 /////making api request to delete user by admin
  Future<Response> adminDeleteUser({userId}) async {
    return await delete(Uri.parse(ApiConstants.adminDeleteUserUrl(userId)),
        headers: ApiHeaders.aunthenticatedHeader);
  }
 /////making api request to approve shipment by admin
  Future<Response> adminApprovedShipment({shipmentId}) async {
    return await patch(
        Uri.parse(ApiConstants.adminApproveShipmentUrl(shipmentId)),
        headers: ApiHeaders.aunthenticatedHeader);
  }

 /////making api request to reject shipment by admin
  Future<Response> adminRejectShipment({shipmentId}) async {
    return await patch(
        Uri.parse(ApiConstants.adminRejectShipmentUrl(shipmentId)),
        headers: ApiHeaders.aunthenticatedHeader);
  }
}
