// To parse this JSON data, do
//
//     final categoryAvailability = categoryAvailabilityFromJson(jsonString);

import 'dart:convert';

CategoryAvailability categoryAvailabilityFromJson(String str) => CategoryAvailability.fromJson(json.decode(str));

String categoryAvailabilityToJson(CategoryAvailability data) => json.encode(data.toJson());

class CategoryAvailability {
    List<Data>? data;

    CategoryAvailability({
        this.data,
    });

    factory CategoryAvailability.fromJson(Map<String, dynamic> json) => CategoryAvailability(
        data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Data {
    int? id;
    String? from;
    String? to;
    String? availability;

    Data({
        this.id,
        this.from,
        this.to,
        this.availability,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        availability: json["availability"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "availability": availability,
    };
}
