// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  String? name;
  String? plate;
  String? type;
  String? color;
  String? year;
  String? gear;

  Car({
    this.name,
    this.plate,
    this.type,
    this.color,
    this.year,
    this.gear,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        name: json["name"],
        plate: json["plate"],
        type: json["type"],
        color: json["color"],
        year: json["year"],
        gear: json["gear"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "plate": plate,
        "type": type,
        "color": color,
        "year": year,
        "gear": gear,
      };

  Car copyWith({String? name, String? plate}) {
    return Car(
      name: name ?? this.name,
      plate: plate ?? this.plate,
    );
  }
}
