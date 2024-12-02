// To parse this JSON data, do
//
//     final vehicles = vehiclesFromJson(jsonString);

import 'dart:convert';

Vehicles vehiclesFromJson(String str) => Vehicles.fromJson(json.decode(str));

String vehiclesToJson(Vehicles data) => json.encode(data.toJson());

class Vehicles {
  List<Datum>? data;

  Vehicles({
    this.data,
  });

  factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? name;
  Car? carType;
  CarBrand? carBrand;
  Car? carModel;
  int? emirateId;
  String? gearType;
  String? color;
  int? year;
  String? plateCode;
  String? plateNumber;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
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
        "name": name,
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
