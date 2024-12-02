// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

import 'dart:convert';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  String? location;
  String? type;

  Location({
    this.location,
    this.type,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        location: json["location"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "type": type,
      };

  Location copyWith({String? location, String? type}) {
    return Location(
      location: location ?? this.location,
      type: type ?? this.type,
    );
  }
}
