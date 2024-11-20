///user shipment model to hold shilpment from backend
class UserShipmentModel {
  int? id;
  String? status;
  String? shipmentReference;
  String? shipmentDate;
  String? modeOfShipment;
  String? priorityLevel;
  String? cargoDescription;
  Null carrier;
  String? courier;
  String? shippingMethod;
  bool? trackingService;
  bool? signatureRequired;
  int? userId;
  String? user;
  Package? package;
  Billing? billing;
  OriginAddress? originAddress;
  OriginAddress? destinationAddress;
  List<Null>? customDocuments;
  String? estimatedDeliveryDate;
  int? totalCost;

  UserShipmentModel(
      {this.id,
      this.status,
      this.shipmentReference,
      this.shipmentDate,
      this.modeOfShipment,
      this.priorityLevel,
      this.cargoDescription,
      this.carrier,
      this.courier,
      this.shippingMethod,
      this.trackingService,
      this.signatureRequired,
      this.userId,
      this.user,
      this.package,
      this.billing,
      this.originAddress,
      this.destinationAddress,
      this.customDocuments,
      this.estimatedDeliveryDate,
      this.totalCost});

  UserShipmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    shipmentReference = json['shipment_reference'];
    shipmentDate = json['shipment_date'];
    modeOfShipment = json['mode_of_shipment'];
    priorityLevel = json['priority_level'];
    cargoDescription = json['cargo_description'];
    carrier = json['carrier'];
    courier = json['courier'];
    shippingMethod = json['shipping_method'];
    trackingService = json['tracking_service'];
    signatureRequired = json['signature_required'];
    userId = json['user_id'];
    user = json['user'];
    package =
        json['package'] != null ? Package.fromJson(json['package']) : null;
    billing =
        json['billing'] != null ? Billing.fromJson(json['billing']) : null;
    originAddress = json['origin_address'] != null
        ? OriginAddress.fromJson(json['origin_address'])
        : null;
    destinationAddress = json['destination_address'] != null
        ? OriginAddress.fromJson(json['destination_address'])
        : null;
    // if (json['custom_documents'] != null) {
    //   customDocuments = <Null>[];
    //   json['custom_documents'].forEach((v) {
    //     customDocuments!.add(Null.fromJson(v));
    //   });
    // }
    estimatedDeliveryDate = json['estimatedDeliveryDate'];
    totalCost = json['total_cost'];
  }
}

class Package {
  int? packageId;
  int? numberOfPackages;
  int? weight;
  dynamic length;
  int? width;
  int? height;
  int? shipmentValue;
  int? insurance;
  String? shipmentContents;
  int? fragile;
  int? hazardousMaterials;
  String? packageDescription;

  Package(
      {this.packageId,
      this.numberOfPackages,
      this.weight,
      this.length,
      this.width,
      this.height,
      this.shipmentValue,
      this.insurance,
      this.shipmentContents,
      this.fragile,
      this.hazardousMaterials,
      this.packageDescription});

  Package.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    numberOfPackages = json['number_of_packages'];
    weight = json['weight'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    shipmentValue = json['shipment_value'];
    insurance = json['insurance'];
    shipmentContents = json['shipment_contents'];
    fragile = json['fragile'];
    hazardousMaterials = json['hazardous_materials'];
    packageDescription = json['package_description'];
  }
}

class Billing {
  String? paymentMethod;
  String? billingAddress;
  String? couponCode;

  Billing({this.paymentMethod, this.billingAddress, this.couponCode});

  Billing.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    billingAddress = json['billing_address'];
    couponCode = json['coupon_code'];
  }
}

class OriginAddress {
  String? type;
  String? name;
  String? mobileNumber;
  String? email;
  String? streetAddress;
  String? city;
  Null lga;
  String? state;
  String? postalCode;
  String? country;
  Null preferredDatetime;
  Null specialInstructions;

  OriginAddress(
      {this.type,
      this.name,
      this.mobileNumber,
      this.email,
      this.streetAddress,
      this.city,
      this.lga,
      this.state,
      this.postalCode,
      this.country,
      this.preferredDatetime,
      this.specialInstructions});

  OriginAddress.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    streetAddress = json['street_address'];
    city = json['city'];
    lga = json['lga'];
    state = json['state'];
    postalCode = json['postal_code'];
    country = json['country'];
    preferredDatetime = json['preferred_datetime'];
    specialInstructions = json['special_instructions'];
  }
}
