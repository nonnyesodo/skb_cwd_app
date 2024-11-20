class ShipmentZoneModel {
  int? id;
  String? name;
  String? countryCode;
  String? description;
  bool? isActive;
 

  ShipmentZoneModel(
      {this.id,
      this.name,
      this.countryCode,
      this.description,
      this.isActive });

  ShipmentZoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    description = json['description'];
    isActive = json['is_active'];
    
  }

   
}
