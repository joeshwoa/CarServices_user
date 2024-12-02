// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));

String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  List<Datum>? data;
  String? message;

  Orders({
    this.data,
    this.message,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int? id;
  String? sku;
  String? type;
  String? status;
  String? paymentMethod;
  String? name;
  int? productId;
  dynamic couponCode;
  String? weight;
  String? totalWeight;
  int? qtyOrdered;
  int? qtyCanceled;
  int? qtyInvoiced;
  int? qtyShipped;
  int? qtyRefunded;
  String? price;
  String? formattedPrice;
  String? basePrice;
  String? formattedBasePrice;
  String? total;
  String? formattedTotal;
  String? baseTotal;
  String? formattedBaseTotal;
  String? totalInvoiced;
  String? formattedTotalInvoiced;
  String? baseTotalInvoiced;
  String? formattedBaseTotalInvoiced;
  String? amountRefunded;
  String? formattedAmountRefunded;
  String? baseAmountRefunded;
  String? formattedBaseAmountRefunded;
  String? discountPercent;
  String? discountAmount;
  String? formattedDiscountAmount;
  String? baseDiscountAmount;
  String? formattedBaseDiscountAmount;
  String? discountInvoiced;
  String? formattedDiscountInvoiced;
  String? baseDiscountInvoiced;
  String? formattedBaseDiscountInvoiced;
  String? discountRefunded;
  String? formattedDiscountRefunded;
  String? baseDiscountRefunded;
  String? formattedBaseDiscountRefunded;
  String? taxPercent;
  String? taxAmount;
  String? formattedTaxAmount;
  String? baseTaxAmount;
  String? formattedBaseTaxAmount;
  String? taxAmountInvoiced;
  String? formattedTaxAmountInvoiced;
  String? baseTaxAmountInvoiced;
  String? formattedBaseTaxAmountInvoiced;
  String? taxAmountRefunded;
  String? formattedTaxAmountRefunded;
  String? baseTaxAmountRefunded;
  String? formattedBaseTaxAmountRefunded;
  double? grantTotal;
  String? formattedGrantTotal;
  double? baseGrantTotal;
  String? formattedBaseGrantTotal;
  List<dynamic>? downloadableLinks;
  String? day;
  String? date;
  int? slotId;
  Vehicle? vehicle;
  Seller? seller;
  dynamic product;
  List<AddOn>? addOns;
  dynamic notes;
  Address? address;
  dynamic child;
  List<dynamic>? children;

  Datum({
    this.id,
    this.sku,
    this.type,
    this.status,
    this.paymentMethod,
    this.name,
    this.productId,
    this.couponCode,
    this.weight,
    this.totalWeight,
    this.qtyOrdered,
    this.qtyCanceled,
    this.qtyInvoiced,
    this.qtyShipped,
    this.qtyRefunded,
    this.price,
    this.formattedPrice,
    this.basePrice,
    this.formattedBasePrice,
    this.total,
    this.formattedTotal,
    this.baseTotal,
    this.formattedBaseTotal,
    this.totalInvoiced,
    this.formattedTotalInvoiced,
    this.baseTotalInvoiced,
    this.formattedBaseTotalInvoiced,
    this.amountRefunded,
    this.formattedAmountRefunded,
    this.baseAmountRefunded,
    this.formattedBaseAmountRefunded,
    this.discountPercent,
    this.discountAmount,
    this.formattedDiscountAmount,
    this.baseDiscountAmount,
    this.formattedBaseDiscountAmount,
    this.discountInvoiced,
    this.formattedDiscountInvoiced,
    this.baseDiscountInvoiced,
    this.formattedBaseDiscountInvoiced,
    this.discountRefunded,
    this.formattedDiscountRefunded,
    this.baseDiscountRefunded,
    this.formattedBaseDiscountRefunded,
    this.taxPercent,
    this.taxAmount,
    this.formattedTaxAmount,
    this.baseTaxAmount,
    this.formattedBaseTaxAmount,
    this.taxAmountInvoiced,
    this.formattedTaxAmountInvoiced,
    this.baseTaxAmountInvoiced,
    this.formattedBaseTaxAmountInvoiced,
    this.taxAmountRefunded,
    this.formattedTaxAmountRefunded,
    this.baseTaxAmountRefunded,
    this.formattedBaseTaxAmountRefunded,
    this.grantTotal,
    this.formattedGrantTotal,
    this.baseGrantTotal,
    this.formattedBaseGrantTotal,
    this.downloadableLinks,
    this.day,
    this.date,
    this.slotId,
    this.vehicle,
    this.seller,
    this.product,
    this.addOns,
    this.notes,
    this.address,
    this.child,
    this.children,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sku: json["sku"],
        type: json["type"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        name: json["name"],
        productId: json["product_id"],
        couponCode: json["coupon_code"],
        weight: json["weight"],
        totalWeight: json["total_weight"],
        qtyOrdered: json["qty_ordered"],
        qtyCanceled: json["qty_canceled"],
        qtyInvoiced: json["qty_invoiced"],
        qtyShipped: json["qty_shipped"],
        qtyRefunded: json["qty_refunded"],
        price: json["price"],
        formattedPrice: json["formatted_price"],
        basePrice: json["base_price"],
        formattedBasePrice: json["formatted_base_price"],
        total: json["total"],
        formattedTotal: json["formatted_total"],
        baseTotal: json["base_total"],
        formattedBaseTotal: json["formatted_base_total"],
        totalInvoiced: json["total_invoiced"],
        formattedTotalInvoiced: json["formatted_total_invoiced"],
        baseTotalInvoiced: json["base_total_invoiced"],
        formattedBaseTotalInvoiced: json["formatted_base_total_invoiced"],
        amountRefunded: json["amount_refunded"],
        formattedAmountRefunded: json["formatted_amount_refunded"],
        baseAmountRefunded: json["base_amount_refunded"],
        formattedBaseAmountRefunded: json["formatted_base_amount_refunded"],
        discountPercent: json["discount_percent"],
        discountAmount: json["discount_amount"],
        formattedDiscountAmount: json["formatted_discount_amount"],
        baseDiscountAmount: json["base_discount_amount"],
        formattedBaseDiscountAmount: json["formatted_base_discount_amount"],
        discountInvoiced: json["discount_invoiced"],
        formattedDiscountInvoiced: json["formatted_discount_invoiced"],
        baseDiscountInvoiced: json["base_discount_invoiced"],
        formattedBaseDiscountInvoiced: json["formatted_base_discount_invoiced"],
        discountRefunded: json["discount_refunded"],
        formattedDiscountRefunded: json["formatted_discount_refunded"],
        baseDiscountRefunded: json["base_discount_refunded"],
        formattedBaseDiscountRefunded: json["formatted_base_discount_refunded"],
        taxPercent: json["tax_percent"],
        taxAmount: json["tax_amount"],
        formattedTaxAmount: json["formatted_tax_amount"],
        baseTaxAmount: json["base_tax_amount"],
        formattedBaseTaxAmount: json["formatted_base_tax_amount"],
        taxAmountInvoiced: json["tax_amount_invoiced"],
        formattedTaxAmountInvoiced: json["formatted_tax_amount_invoiced"],
        baseTaxAmountInvoiced: json["base_tax_amount_invoiced"],
        formattedBaseTaxAmountInvoiced:
            json["formatted_base_tax_amount_invoiced"],
        taxAmountRefunded: json["tax_amount_refunded"],
        formattedTaxAmountRefunded: json["formatted_tax_amount_refunded"],
        baseTaxAmountRefunded: json["base_tax_amount_refunded"],
        formattedBaseTaxAmountRefunded:
            json["formatted_base_tax_amount_refunded"],
        grantTotal: json["grant_total"]?.toDouble(),
        formattedGrantTotal: json["formatted_grant_total"],
        baseGrantTotal: json["base_grant_total"]?.toDouble(),
        formattedBaseGrantTotal: json["formatted_base_grant_total"],
        downloadableLinks: json["downloadable_links"] == null
            ? []
            : List<dynamic>.from(json["downloadable_links"]!.map((x) => x)),
        day: json["day"],
        date: json["date"],
        slotId: json["slot_id"],
        vehicle:
            json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        product: json["product"],
        addOns: json["add_ons"] == null
            ? []
            : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
        notes: json["notes"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        child: json["child"],
        children: json["children"] == null
            ? []
            : List<dynamic>.from(json["children"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "type": type,
        "status": status,
        "payment_method": paymentMethod,
        "name": name,
        "product_id": productId,
        "coupon_code": couponCode,
        "weight": weight,
        "total_weight": totalWeight,
        "qty_ordered": qtyOrdered,
        "qty_canceled": qtyCanceled,
        "qty_invoiced": qtyInvoiced,
        "qty_shipped": qtyShipped,
        "qty_refunded": qtyRefunded,
        "price": price,
        "formatted_price": formattedPrice,
        "base_price": basePrice,
        "formatted_base_price": formattedBasePrice,
        "total": total,
        "formatted_total": formattedTotal,
        "base_total": baseTotal,
        "formatted_base_total": formattedBaseTotal,
        "total_invoiced": totalInvoiced,
        "formatted_total_invoiced": formattedTotalInvoiced,
        "base_total_invoiced": baseTotalInvoiced,
        "formatted_base_total_invoiced": formattedBaseTotalInvoiced,
        "amount_refunded": amountRefunded,
        "formatted_amount_refunded": formattedAmountRefunded,
        "base_amount_refunded": baseAmountRefunded,
        "formatted_base_amount_refunded": formattedBaseAmountRefunded,
        "discount_percent": discountPercent,
        "discount_amount": discountAmount,
        "formatted_discount_amount": formattedDiscountAmount,
        "base_discount_amount": baseDiscountAmount,
        "formatted_base_discount_amount": formattedBaseDiscountAmount,
        "discount_invoiced": discountInvoiced,
        "formatted_discount_invoiced": formattedDiscountInvoiced,
        "base_discount_invoiced": baseDiscountInvoiced,
        "formatted_base_discount_invoiced": formattedBaseDiscountInvoiced,
        "discount_refunded": discountRefunded,
        "formatted_discount_refunded": formattedDiscountRefunded,
        "base_discount_refunded": baseDiscountRefunded,
        "formatted_base_discount_refunded": formattedBaseDiscountRefunded,
        "tax_percent": taxPercent,
        "tax_amount": taxAmount,
        "formatted_tax_amount": formattedTaxAmount,
        "base_tax_amount": baseTaxAmount,
        "formatted_base_tax_amount": formattedBaseTaxAmount,
        "tax_amount_invoiced": taxAmountInvoiced,
        "formatted_tax_amount_invoiced": formattedTaxAmountInvoiced,
        "base_tax_amount_invoiced": baseTaxAmountInvoiced,
        "formatted_base_tax_amount_invoiced": formattedBaseTaxAmountInvoiced,
        "tax_amount_refunded": taxAmountRefunded,
        "formatted_tax_amount_refunded": formattedTaxAmountRefunded,
        "base_tax_amount_refunded": baseTaxAmountRefunded,
        "formatted_base_tax_amount_refunded": formattedBaseTaxAmountRefunded,
        "grant_total": grantTotal,
        "formatted_grant_total": formattedGrantTotal,
        "base_grant_total": baseGrantTotal,
        "formatted_base_grant_total": formattedBaseGrantTotal,
        "downloadable_links": downloadableLinks == null
            ? []
            : List<dynamic>.from(downloadableLinks!.map((x) => x)),
        "day": day,
        "date": date,
        "slot_id": slotId,
        "vehicle": vehicle?.toJson(),
        "seller": seller?.toJson(),
        "product": product,
        "add_ons": addOns == null
            ? []
            : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "notes": notes,
        "address": address?.toJson(),
        "child": child,
        "children":
            children == null ? [] : List<dynamic>.from(children!.map((x) => x)),
      };
}

class AddOn {
  int? id;
  int? qty;
  String? name;
  int? price;

  AddOn({
    this.id,
    this.qty,
    this.name,
    this.price,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        id: json["id"],
        qty: json["qty"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qty": qty,
        "name": name,
        "price": price,
      };
}

class Address {
  int? id;
  String? addressType;
  dynamic parentAddressId;
  int? customerId;
  dynamic cartId;
  dynamic orderId;
  String? firstName;
  String? lastName;
  dynamic gender;
  dynamic companyName;
  List<String>? address;
  String? city;
  dynamic state;
  dynamic country;
  dynamic postcode;
  dynamic email;
  dynamic phone;
  dynamic vatId;
  bool? defaultAddress;
  bool? useForShipping;
  List<dynamic>? additional;

  Address({
    this.id,
    this.addressType,
    this.parentAddressId,
    this.customerId,
    this.cartId,
    this.orderId,
    this.firstName,
    this.lastName,
    this.gender,
    this.companyName,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.email,
    this.phone,
    this.vatId,
    this.defaultAddress,
    this.useForShipping,
    this.additional,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        addressType: json["address_type"],
        parentAddressId: json["parent_address_id"],
        customerId: json["customer_id"],
        cartId: json["cart_id"],
        orderId: json["order_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        companyName: json["company_name"],
        address: json["address"] == null
            ? []
            : List<String>.from(json["address"]!.map((x) => x)),
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postcode: json["postcode"],
        email: json["email"],
        phone: json["phone"],
        vatId: json["vat_id"],
        defaultAddress: json["default_address"],
        useForShipping: json["use_for_shipping"],
        additional: json["additional"] == null
            ? []
            : List<dynamic>.from(json["additional"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address_type": addressType,
        "parent_address_id": parentAddressId,
        "customer_id": customerId,
        "cart_id": cartId,
        "order_id": orderId,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "company_name": companyName,
        "address":
            address == null ? [] : List<dynamic>.from(address!.map((x) => x)),
        "city": city,
        "state": state,
        "country": country,
        "postcode": postcode,
        "email": email,
        "phone": phone,
        "vat_id": vatId,
        "default_address": defaultAddress,
        "use_for_shipping": useForShipping,
        "additional": additional == null
            ? []
            : List<dynamic>.from(additional!.map((x) => x)),
      };
}

class Seller {
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
  int? rating;
  int? votes;
  bool? favourite;
  bool? promoted;

  Seller({
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
    this.rating,
    this.votes,
    this.favourite,
    this.promoted,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        shopTitle: json["shop_title"],
        description: json["description"] == null
            ? []
            : List<dynamic>.from(json["description"]!.map((x) => x)),
        banner: json["banner"],
        emiratesId: json["emirates_id"],
        address1: json["address1"],
        address2: json["address2"],
        phone: json["phone"],
        cityId: json["city_id"],
        logo: json["logo"],
        rating: json["rating"],
        votes: json["votes"],
        favourite: json["favourite"],
        promoted: json["promoted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "shop_title": shopTitle,
        "description": description == null
            ? []
            : List<dynamic>.from(description!.map((x) => x)),
        "banner": banner,
        "emirates_id": emiratesId,
        "address1": address1,
        "address2": address2,
        "phone": phone,
        "city_id": cityId,
        "logo": logo,
        "rating": rating,
        "votes": votes,
        "favourite": favourite,
        "promoted": promoted,
      };
}

class Vehicle {
  int? id;
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

  Vehicle({
    this.id,
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

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
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
