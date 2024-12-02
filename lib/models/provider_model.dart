// To parse this JSON data, do
//
//     final provider = providerFromJson(jsonString);

import 'dart:convert';
import 'package:autoflex/models/item_model.dart';

Provider providerFromJson(String str) => Provider.fromJson(json.decode(str));

String providerToJson(Provider data) => json.encode(data.toJson());

class Provider {
  bool? isPromoted;
  String? logo;
  String? name;
  bool? favourited;
  List<Service>? services;
  int? votes;
  double? rating;

  Provider({
    this.isPromoted,
    this.logo,
    this.name,
    this.favourited,
    this.services,
    this.votes,
    this.rating,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        isPromoted: json["isPromoted"],
        logo: json["logo"],
        name: json["name"],
        favourited: json["favourited"],
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"]!.map((x) => Service.fromJson(x))),
        votes: json["votes"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "isPromoted": isPromoted,
        "logo": logo,
        "name": name,
        "favourited": favourited,
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
        "votes": votes,
        "rating": rating,
      };
}

class Service {
  String? name;
  double? price;
  List<AddOn>? addOns;
  List<String>? description;
  List<String>? details;

  Service({
    this.name,
    this.price,
    this.addOns,
    this.description,
    this.details,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        name: json["name"],
        price: json["price"],
        addOns: json["add-ons"] == null
            ? []
            : List<AddOn>.from(json["add-ons"]!.map((x) => AddOn.fromJson(x))),
        description: json["description"] == null
            ? []
            : List<String>.from(json["description"]!.map((x) => x)),
        details: json["details"] == null
            ? []
            : List<String>.from(json["details"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "add-ons": addOns == null
            ? []
            : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "description": description == null
            ? []
            : List<dynamic>.from(description!.map((x) => x)),
        "details":
            details == null ? [] : List<dynamic>.from(details!.map((x) => x)),
      };
}
