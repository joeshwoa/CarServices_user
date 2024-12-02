// To parse this JSON data, do
//
//     final vehicle = vehicleFromJson(jsonString);

import 'dart:convert';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  Data? data;
  String? message;

  Vehicle({
    this.data,
    this.message,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
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
  Car? carType;
  CarBrand? carBrand;
  Car? carModel;
  dynamic emirateId;
  String? gearType;
  String? color;
  int? year;
  String? plateCode;
  String? plateNumber;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.carType,
    this.carBrand,
    this.carModel,
    this.emirateId,
    this.gearType,
    this.color,
    this.year,
    this.plateCode,
    this.plateNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        carType:
            json["car_type"] == null ? null : Car.fromJson(json["car_type"]),
        carBrand: json["car_brand"] == null
            ? null
            : CarBrand.fromJson(json["car_brand"]),
        carModel:
            json["car_model"] == null ? null : Car.fromJson(json["car_model"]),
        emirateId: json["emirate_id"],
        gearType: json["gear_type"],
        color: json["color"],
        year: json["year"],
        plateCode: json["plate_code"],
        plateNumber: json["plate_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "car_type": carType?.toJson(),
        "car_brand": carBrand?.toJson(),
        "car_model": carModel?.toJson(),
        "emirate_id": emirateId,
        "gear_type": gearType,
        "color": color,
        "year": year,
        "plate_code": plateCode,
        "plate_number": plateNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class CarBrand {
  int? id;
  String? name;

  CarBrand({
    this.id,
    this.name,
  });

  factory CarBrand.fromJson(Map<String, dynamic> json) => CarBrand(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Car {
  int? id;
  String? name;
  int? carBrandId;

  Car({
    this.id,
    this.name,
    this.carBrandId,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        name: json["name"],
        carBrandId: json["car_brand_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "car_brand_id": carBrandId,
      };
}
