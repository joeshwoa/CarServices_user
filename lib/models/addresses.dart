// To parse this JSON data, do
//
//     final addresses = addressesFromJson(jsonString);

import 'dart:convert';

Addresses addressesFromJson(String str) => Addresses.fromJson(json.decode(str));

String addressesToJson(Addresses data) => json.encode(data.toJson());

class Addresses {
  List<Datum>? data;
  Links? links;
  Meta? meta;

  Addresses({
    this.data,
    this.links,
    this.meta,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Datum {
  int? id;
  String? firstName;
  String? lastName;
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

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
