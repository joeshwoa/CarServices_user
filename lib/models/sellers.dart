// To parse this JSON data, do
//
//     final sellers = sellersFromJson(jsonString);

import 'dart:convert';

Sellers sellersFromJson(String str) => Sellers.fromJson(json.decode(str));

String sellersToJson(Sellers data) => json.encode(data.toJson());

class Sellers {
    List<Datum>? data;

    Sellers({
        this.data,
    });

    factory Sellers.fromJson(Map<String, dynamic> json) => Sellers(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? name;
    dynamic url;
    dynamic shopTitle;
    List<dynamic>? description;
    dynamic banner;
    dynamic emiratesId;
    dynamic address1;
    dynamic address2;
    String? phone;
    dynamic cityId;
    String? logo;
    List<Product>? products;
    double? rating;
    int? votes;
    bool? favourite;
    bool? promoted;

    Datum({
        this.id,
        this.name,
        this.url,
        this.shopTitle,
        this.description,
        this.banner,
        this.emiratesId,
        this.address1,
        this.address2,
        this.phone,
        this.cityId,
        this.logo,
        this.products,
        this.rating,
        this.votes,
        this.favourite,
        this.promoted,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        shopTitle: json["shop_title"],
        description: json["description"] == null ? [] : List<dynamic>.from(json["description"]!.map((x) => x)),
        banner: json["banner"],
        emiratesId: json["emirates_id"],
        address1: json["address1"],
        address2: json["address2"],
        phone: json["phone"],
        cityId: json["city_id"],
        logo: json["logo"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        rating: json["rating"]?.toDouble(),
        votes: json["votes"],
        favourite: json["favourite"],
        promoted: json["promoted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "shop_title": shopTitle,
        "description": description == null ? [] : List<dynamic>.from(description!.map((x) => x)),
        "banner": banner,
        "emirates_id": emiratesId,
        "address1": address1,
        "address2": address2,
        "phone": phone,
        "city_id": cityId,
        "logo": logo,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "rating": rating,
        "votes": votes,
        "favourite": favourite,
        "promoted": promoted,
    };
}

class Product {
    int? id;
    String? name;
    String? sku;
    double? price;
    String? formattedPrice;
    List<String>? description;
    List<String>? additionalInformation;
    List<AddOn>? addOns;
    String? duration;
    int? powerOutlet;
    DateTime? createdAt;
    DateTime? updatedAt;

    Product({
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

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        price: json["price"]?.toDouble(),
        formattedPrice: json["formatted_price"],
        description: json["description"] == null ? [] : List<String>.from(json["description"]!.map((x) => x)),
        additionalInformation: json["additional_information"] == null ? [] : List<String>.from(json["additional_information"]!.map((x) => x)),
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
