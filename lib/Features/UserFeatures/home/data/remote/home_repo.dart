import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'; 

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
 "addresses": [
    {
       "type": "Origin",
       "name": "John Doe",
      "email": "john.doe@example.com",
       "phone": "1234567890",
      "country": "USA",
      "state": "California",
      "lga": "N/A",
      "city": "Los Angeles",
       "street": "123 Elm Street",
       "latitude": 34.0522,
       "longitude": -118.2437,
      "postal_code": "90001"
    },
    {
      "type": "Destination",
      "name": "Jane Smith",
      "email": "jane.smith@example.com",
      "phone": "0987654321",
      "country": "Canada",
      "state": "Ontario",
      "lga": "N/A",
      "city": "Toronto",
      "street": "456 Oak Avenue",
      "latitude": 43.6532,
      "longitude": -79.3832,
      "postal_code": "M5A 1A1"
    }
  ]
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
  Future<Response> fetchShipmentZones() async {
    return await get(Uri.parse(ApiConstants.fetchShipmentZoneUrl),
        headers: ApiHeaders.aunthenticatedHeader);
  }
}
