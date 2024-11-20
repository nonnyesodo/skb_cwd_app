import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/api_constants.dart';

class HomeRepo {
  Future<Response> fetchShipments() async {
    return await get(Uri.parse(ApiConstants.userShipmentUrl),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> createShipment(
      {priorityLevel,
      shipmentMode,
      packageDescription,
      numberOfPackages,
      insurance,
      weight,
      width,
      height,
      shipmentValue,
      shipmentContent,
      fragile,
      hazardous,
      userPreferredPickupDatetime,
      userSpecialPickUpInstructions,
      userName,
      userEmail,
      userMobile,
      userCountry,
      userPostalCode,
      receiverPreferredDatetime,
      receiverSpecialPickUpInstructions,
      userLga,
      userCity,
      userState,
      userAddress,
      receiverName,
      receiverEmail,
      receiverMobile,
      receiverCountry,
      receiverPostalCode,
      receiverLga,
      receiverCity,
      receiverState,
      receiverAddress,
      shippingMethod}) async {
    var body = {
      "shipment_date": DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(const Duration(days: 30)))
          .toString(),
      "shipment_mode": shipmentMode,
      "courier_id": 1,
      "priority_level": priorityLevel,

      "package_description": packageDescription,
      "number_of_packages": numberOfPackages,
      "weight": weight,
      // "length": length,
      "width": width,
      "height": height,
      "shipment_value": shipmentValue,
      "insurance": insurance,
      "shipment_content": shipmentContent,
      "fragile": fragile,
      "hazardous": hazardous,
      "addresses": [
        {
          "type": "Origin",
          "name": userName,
          "email": userEmail,
          // "mobile_number": userMobile,
          "mobile_number": "07037755663",

          "preferred_datetime": userPreferredPickupDatetime,
          "special_instructions": userSpecialPickUpInstructions,
          "country": userCountry,
          "state": userState,
          "lga": userLga,
          "city": userCity,
          "street_address": userAddress,
          "postal_code": userPostalCode
        },
        {
          "type": "Destination",
          "name": receiverName,
          "email": receiverEmail,
          "mobile_number": receiverMobile,
          "preferred_datetime": receiverPreferredDatetime ?? '',
          "special_instructions": receiverSpecialPickUpInstructions,
          "country": receiverCountry,
          "state": receiverState,
          "lga": receiverLga,
          "city": receiverCity,
          "street_address": receiverAddress,
          "postal_code": receiverPostalCode
        }
      ],
      "shipping_method": shippingMethod,
      "billing": {
        "method": "Paypal",
        "billing_address": "mddldd",
        "coupon": "DISCOUNT2024"
      }
    };
    log(body.toString());
    return await post(Uri.parse(ApiConstants.createShipmentUrl),
        headers: ApiHeaders.aunthenticatedHeader, body: jsonEncode(body));
  }

  Future<Response> cancelShipment({shipmentId}) async {
    return await patch(Uri.parse(ApiConstants.cancelShipmentUrl(shipmentId)),
        headers: ApiHeaders.aunthenticatedHeader);
  }

  Future<Response> userComplain({subject, message, images}) async {
    var body = {"subject": subject, "message": message, "images": images};
    return await post(Uri.parse(ApiConstants.userComplaintUrl),
        headers: ApiHeaders.aunthenticatedHeader, body: jsonEncode(body));
  }

  Future<Response> confirmShipment() async {
    return await post(Uri.parse(ApiConstants.userConfirmShipmentUrl),
        headers: ApiHeaders.aunthenticatedHeader);
  }
}
