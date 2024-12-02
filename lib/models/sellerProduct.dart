// To parse this JSON data, do
//
//     final sellerProduct = sellerProductFromJson(jsonString);

import 'dart:convert';

SellerProduct sellerProductFromJson(String str) => SellerProduct.fromJson(json.decode(str));

String sellerProductToJson(SellerProduct data) => json.encode(data.toJson());

class SellerProduct {
    Data? data;

    SellerProduct({
        this.data,
    });

    factory SellerProduct.fromJson(Map<String, dynamic> json) => SellerProduct(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? name;
    String? sku;
    double? price;
    String? formattedPrice;
    List<String>? description;
    List<dynamic>? additionalInformation;
    List<AddOn>? addOns;
    dynamic duration;
    dynamic powerOutlet;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.name,
        this.sku,
        this.price,
        this.formattedPrice,
        this.description,
        this.additionalInformation,
        this.addOns,
        this.duration,
        this.powerOutlet,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        price: json["price"]?.toDouble(),
        formattedPrice: json["formatted_price"],
        description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
        additionalInformation: json["additional_information"] == null ? [] : List<dynamic>.from(json["additional_information"]!.map((x) => x)),
        addOns: json["add_ons"] == null ? [] : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
        duration: json["duration"],
        powerOutlet: json["power_outlet"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "price": price,
        "formatted_price": formattedPrice,
        "description": description == null ? [] : List<dynamic>.from(description!.map((x) => x)),
        "additional_information": additionalInformation == null ? [] : List<dynamic>.from(additionalInformation!.map((x) => x)),
        "add_ons": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "duration": duration,
        "power_outlet": powerOutlet,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class AddOn {
    int? id;
    String? name;
    double? price;
    String? formattedPrice;
    String? description;
    bool? multiQty;
    int? productId;
    int? sellerId;
    DateTime? createdAt;
    DateTime? updatedAt;

    AddOn({
        this.id,
        this.name,
        this.price,
        this.formattedPrice,
        this.description,
        this.multiQty,
        this.productId,
        this.sellerId,
        this.createdAt,
        this.updatedAt,
    });

    factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        formattedPrice: json["formatted_price"],
        description: json["description"],
        multiQty: json["multi_qty"],
        productId: json["product_id"],
        sellerId: json["seller_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "formatted_price": formattedPrice,
        "description": description,
        "multi_qty": multiQty,
        "product_id": productId,
        "seller_id": sellerId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
