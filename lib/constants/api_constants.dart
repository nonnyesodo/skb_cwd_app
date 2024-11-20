String bearerToken = '';


////all api endpoints
class ApiConstants {
  static const String baseUrl = 'https://insights.alwaysdata.net/api/v1';

  static const String loginUrl = '$baseUrl/login';
  static const String registerUrl = '$baseUrl/register';
  static const String createShipmentUrl = '$baseUrl/shipment';
  static const String userShipmentUrl = '$baseUrl/shipment';
  static const String userComplaintUrl = '$baseUrl/user/complain';
  static const String userConfirmShipmentUrl = '$baseUrl/shipment/confirm';
  static const String fetchShipmentZoneUrl = '$baseUrl/shipment/zone';
  //////Admin url
  static const String adminCreateUserUrl = '$baseUrl/admin/user';
  static String adminDeleteUserUrl(userId) => '$baseUrl/admin/user/$userId';
  static String adminApproveShipmentUrl(id) =>
      '$baseUrl/admin/shipment/approve/$id';
  static String adminRejectShipmentUrl(id) =>
      '$baseUrl/admin/shipment/reject/$id';
  static String cancelShipmentUrl(id) => '$baseUrl/shipment/cancel/$id';
  static String adminShipmentUrl(status) => '$baseUrl/shipment?status=$status';
}


///api headers
class ApiHeaders {
  static const unaunthenticatedHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  static final aunthenticatedHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $bearerToken'
  };
}
