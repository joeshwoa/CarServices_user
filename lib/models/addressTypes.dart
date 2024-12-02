// To parse this JSON data, do
//
//     final addressTypes = addressTypesFromJson(jsonString);

import 'dart:convert';

AddressTypes addressTypesFromJson(String str) => AddressTypes.fromJson(json.decode(str));

String addressTypesToJson(AddressTypes data) => json.encode(data.toJson());

class AddressTypes {
    List<Datum>? data;

    AddressTypes({
        this.data,
    });

    factory AddressTypes.fromJson(Map<String, dynamic> json) => AddressTypes(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? type;
    List<Child>? children;

    Datum({
        this.id,
        this.type,
        this.children,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        children: json["children"] == null ? [] : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
    };
}

class Child {
    int? id;
    String? type;
    int? parentId;
    int? depth;
    String? path;
    List<dynamic>? children;

    Child({
        this.id,
        this.type,
        this.parentId,
        this.depth,
        this.path,
        this.children,
    });

    factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["id"],
        type: json["type"],
        parentId: json["parent_id"],
        depth: json["depth"],
        path: json["path"],
        children: json["children"] == null ? [] : List<dynamic>.from(json["children"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "parent_id": parentId,
        "depth": depth,
        "path": path,
        "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x)),
    };
}
