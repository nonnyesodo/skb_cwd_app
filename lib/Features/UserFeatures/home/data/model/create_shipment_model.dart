class CreateShipmentModel {
  dynamic priorityLevel;
  dynamic shipmentMode;
  dynamic packageDescription;
  dynamic numberOfPackages;
  dynamic insurance;
  dynamic weight;
 
  dynamic width;
  dynamic height;
  dynamic shipmentValue;
  dynamic shipmentContent;
  dynamic fragile;
  dynamic hazardous;
  dynamic userPreferredDatetime;
  dynamic userSpecialPickUpInstructions;
  dynamic userName;
  dynamic userEmail;
  dynamic userMobile;
  dynamic userCountry;
  dynamic userPostalCode;
  dynamic receiverPreferredDatetime;
  dynamic receiverSpecialPickUpInstructions;
  dynamic userLga;
  dynamic userCity;
  dynamic userState;
  dynamic userAddress;
  dynamic receiverName;
  dynamic receiverEmail;
  dynamic receiverMobile;
  dynamic receiverCountry;
  dynamic receiverPostalCode;
  dynamic receiverLga;
  dynamic receiverCity;
  dynamic receiverState;
  dynamic receiverAddress;
  dynamic shippingMethod;
  CreateShipmentModel(
      {required shipmentMode,
      required priorityLevel,
      required packageDescription,
      required numberOfPackages,
      required weight,
    
      required width,
      required height,
      required shipmentValue,
      required shipmentContent,
      required fragile,
      required hazardous,
      required userPreferredPickupDatetime,
      required userSpecialPickUpInstructions,
      required userName,
      required userEmail,
      required userMobile,
      required userCountry,
      required userPostalCode,
      required receiverPreferredDatetime,
      required receiverSpecialPickUpInstructions,
      required userLga,
      required userCity,
      required userState,
      required userAddress,
      required receiverName,
      required receiverEmail,
      required receiverMobile,
      required receiverCountry,
      required receiverPostalCode,
      required receiverLga,
      required receiverCity,
      required receiverState,
      required receiverAddress,
      required shippingMethod,
      required insurance});
}
