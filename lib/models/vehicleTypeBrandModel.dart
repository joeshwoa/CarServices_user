// To parse this JSON data, do
//
//     final vehicleTypeBrandModel = vehicleTypeBrandModelFromJson(jsonString);

import 'dart:convert';

VehicleTypeBrandModel vehicleTypeBrandModelFromJson(String str) => VehicleTypeBrandModel.fromJson(json.decode(str));

String vehicleTypeBrandModelToJson(VehicleTypeBrandModel data) => json.encode(data.toJson());

class VehicleTypeBrandModel {
    List<Data>? data;

    VehicleTypeBrandModel({
        this.data,
    });

    factory VehicleTypeBrandModel.fromJson(Map<String, dynamic> json) => VehicleTypeBrandModel(
        data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Data {
    int? id;
    String? name;
    int? carBrandId;

    Data({
        this.id,
        this.name,
        this.carBrandId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
