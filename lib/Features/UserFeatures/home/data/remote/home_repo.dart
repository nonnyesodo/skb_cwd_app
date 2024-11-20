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
      { 
      dropOffId,cargoDescription,modOfShipment
    ,typesOfGoods  ,originZoneId ,destinationZoneId,itemName
,quantity ,weight,destinationAddressId ,length,width,height,remarks,declaredValue ,originAddressId}) async {
    var body = {
    'drop_off_point_id':dropOffId,"cargo_description":cargoDescription,
    "mod_of_shipment": modOfShipment , "types_of_goods":typesOfGoods , "agent_code": "AGT123", "route_code": "RT123",
  "route_type": "local",
  "declaration": "Declared as $cargoDescription",
  "origin_zone_id": originZoneId,
  "destination_zone_id": destinationZoneId,"items": [
    {
      "item_name": itemName,
      "quantity": quantity,
      "weight": weight,
      "length": length,
      "width": width,
      "height": height,
      "remarks": remarks,
      "declared_value": declaredValue
    },],"documents": [
    {
      "document_type": "Invoice",
      "file": "/uploads/documents/invoice.pdf"
    },
    {
      "document_type": "Customs Declaration",
      "file": "/uploads/documents/customs_declaration.pdf"
    }
  ],
  "origin_address_id": originAddressId,
 "destination_address_id": destinationAddressId,
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
