// To parse this JSON data, do
//
//     final addAddress = addAddressFromJson(jsonString);

import 'dart:convert';

AddAddress addAddressFromJson(String str) =>
    AddAddress.fromJson(json.decode(str));

String addAddressToJson(AddAddress data) => json.encode(data.toJson());

class AddAddress {
  Data? data;
  String? message;

  AddAddress({
    this.data,
    this.message,
  });

  factory AddAddress.fromJson(Map<String, dynamic> json) => AddAddress(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  dynamic firstName;
  dynamic lastName;
  dynamic companyName;
  dynamic vatId;
  String? address;
  dynamic country;
  dynamic countryName;
  String? state;
  String? city;
  String? buildingName;
  String? apartmentNo;
  String? parkingArea;
  String? customField;
  List<dynamic>? additional;
  String? type;
  int? addressTypeId;
  Emirate? emirate;
  Emirate? emirateCity;
  dynamic postcode;
  dynamic phone;
  dynamic email;
  bool? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.companyName,
    this.vatId,
    this.address,
    this.country,
    this.countryName,
    this.state,
    this.city,
    this.buildingName,
    this.apartmentNo,
    this.parkingArea,
    this.customField,
    this.additional,
    this.type,
    this.addressTypeId,
    this.emirate,
    this.emirateCity,
    this.postcode,
    this.phone,
    this.email,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        companyName: json["company_name"],
        vatId: json["vat_id"],
        address: json["address"],
        country: json["country"],
        countryName: json["country_name"],
        state: json["state"],
        city: json["city"],
        buildingName: json["building_name"],
        apartmentNo: json["apartment_no"],
        parkingArea: json["parking_area"],
        customField: json["custom_field"],
        additional: json["additional"] == null
            ? []
            : List<dynamic>.from(json["additional"]!.map((x) => x)),
        type: json["type"],
        addressTypeId: json["address_type_id"],
        emirate:
            json["emirate"] == null ? null : Emirate.fromJson(json["emirate"]),
        emirateCity: json["emirate_city"] == null
            ? null
            : Emirate.fromJson(json["emirate_city"]),
        postcode: json["postcode"],
        phone: json["phone"],
        email: json["email"],
        isDefault: json["is_default"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "company_name": companyName,
        "vat_id": vatId,
        "address": address,
        "country": country,
        "country_name": countryName,
        "state": state,
        "city": city,
        "building_name": buildingName,
        "apartment_no": apartmentNo,
        "parking_area": parkingArea,
        "custom_field": customField,
        "additional": additional == null
            ? []
            : List<dynamic>.from(additional!.map((x) => x)),
        "type": type,
        "address_type_id": addressTypeId,
        "emirate": emirate?.toJson(),
        "emirate_city": emirateCity?.toJson(),
        "postcode": postcode,
        "phone": phone,
        "email": email,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Emirate {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? emirateId;

  Emirate({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.emirateId,
  });

  factory Emirate.fromJson(Map<String, dynamic> json) => Emirate(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        emirateId: json["emirate_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "emirate_id": emirateId,
      };
}
