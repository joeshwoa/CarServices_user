// To parse this JSON data, do
//
//     final addCartItem = addCartItemFromJson(jsonString);

import 'dart:convert';

AddCartItem addCartItemFromJson(String str) =>
    AddCartItem.fromJson(json.decode(str));

String addCartItemToJson(AddCartItem data) => json.encode(data.toJson());

class AddCartItem {
  Data? data;
  String? message;

  AddCartItem({
    this.data,
    this.message,
  });

  factory AddCartItem.fromJson(Map<String, dynamic> json) => AddCartItem(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  String? customerEmail;
  dynamic customerFirstName;
  dynamic customerLastName;
  dynamic shippingMethod;
  dynamic couponCode;
  int? isGift;
  int? itemsCount;
  int? itemsQty;
  dynamic exchangeRate;
  String? globalCurrencyCode;
  String? baseCurrencyCode;
  String? channelCurrencyCode;
  String? cartCurrencyCode;
  double? grandTotal;
  String? formattedGrandTotal;
  double? baseGrandTotal;
  String? formattedBaseGrandTotal;
  int? subTotal;
  String? formattedSubTotal;
  int? baseSubTotal;
  String? formattedBaseSubTotal;
  double? taxTotal;
  String? formattedTaxTotal;
  double? baseTaxTotal;
  String? formattedBaseTaxTotal;
  int? discount;
  String? formattedDiscount;
  int? baseDiscount;
  String? formattedBaseDiscount;
  dynamic checkoutMethod;
  int? isGuest;
  int? isActive;
  dynamic conversionTime;
  dynamic customer;
  dynamic channel;
  List<Item>? items;
  dynamic selectedShippingRate;
  dynamic payment;
  dynamic billingAddress;
  dynamic shippingAddress;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? taxes;
  String? formattedTaxes;
  String? baseTaxes;
  String? formattedBaseTaxes;
  String? formattedDiscountedSubTotal;
  String? formattedBaseDiscountedSubTotal;

  Data({
    this.id,
    this.customerEmail,
    this.customerFirstName,
    this.customerLastName,
    this.shippingMethod,
    this.couponCode,
    this.isGift,
    this.itemsCount,
    this.itemsQty,
    this.exchangeRate,
    this.globalCurrencyCode,
    this.baseCurrencyCode,
    this.channelCurrencyCode,
    this.cartCurrencyCode,
    this.grandTotal,
    this.formattedGrandTotal,
    this.baseGrandTotal,
    this.formattedBaseGrandTotal,
    this.subTotal,
    this.formattedSubTotal,
    this.baseSubTotal,
    this.formattedBaseSubTotal,
    this.taxTotal,
    this.formattedTaxTotal,
    this.baseTaxTotal,
    this.formattedBaseTaxTotal,
    this.discount,
    this.formattedDiscount,
    this.baseDiscount,
    this.formattedBaseDiscount,
    this.checkoutMethod,
    this.isGuest,
    this.isActive,
    this.conversionTime,
    this.customer,
    this.channel,
    this.items,
    this.selectedShippingRate,
    this.payment,
    this.billingAddress,
    this.shippingAddress,
    this.createdAt,
    this.updatedAt,
    this.taxes,
    this.formattedTaxes,
    this.baseTaxes,
    this.formattedBaseTaxes,
    this.formattedDiscountedSubTotal,
    this.formattedBaseDiscountedSubTotal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        customerEmail: json["customer_email"],
        customerFirstName: json["customer_first_name"],
        customerLastName: json["customer_last_name"],
        shippingMethod: json["shipping_method"],
        couponCode: json["coupon_code"],
        isGift: json["is_gift"],
        itemsCount: json["items_count"],
        itemsQty: json["items_qty"],
        exchangeRate: json["exchange_rate"],
        globalCurrencyCode: json["global_currency_code"],
        baseCurrencyCode: json["base_currency_code"],
        channelCurrencyCode: json["channel_currency_code"],
        cartCurrencyCode: json["cart_currency_code"],
        grandTotal: json["grand_total"]?.toDouble(),
        formattedGrandTotal: json["formatted_grand_total"],
        baseGrandTotal: json["base_grand_total"]?.toDouble(),
        formattedBaseGrandTotal: json["formatted_base_grand_total"],
        subTotal: json["sub_total"],
        formattedSubTotal: json["formatted_sub_total"],
        baseSubTotal: json["base_sub_total"],
        formattedBaseSubTotal: json["formatted_base_sub_total"],
        taxTotal: json["tax_total"]?.toDouble(),
        formattedTaxTotal: json["formatted_tax_total"],
        baseTaxTotal: json["base_tax_total"]?.toDouble(),
        formattedBaseTaxTotal: json["formatted_base_tax_total"],
        discount: json["discount"],
        formattedDiscount: json["formatted_discount"],
        baseDiscount: json["base_discount"],
        formattedBaseDiscount: json["formatted_base_discount"],
        checkoutMethod: json["checkout_method"],
        isGuest: json["is_guest"],
        isActive: json["is_active"],
        conversionTime: json["conversion_time"],
        customer: json["customer"],
        channel: json["channel"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        selectedShippingRate: json["selected_shipping_rate"],
        payment: json["payment"],
        billingAddress: json["billing_address"],
        shippingAddress: json["shipping_address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        taxes: json["taxes"],
        formattedTaxes: json["formatted_taxes"],
        baseTaxes: json["base_taxes"],
        formattedBaseTaxes: json["formatted_base_taxes"],
        formattedDiscountedSubTotal: json["formatted_discounted_sub_total"],
        formattedBaseDiscountedSubTotal:
            json["formatted_base_discounted_sub_total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_email": customerEmail,
        "customer_first_name": customerFirstName,
        "customer_last_name": customerLastName,
        "shipping_method": shippingMethod,
        "coupon_code": couponCode,
        "is_gift": isGift,
        "items_count": itemsCount,
        "items_qty": itemsQty,
        "exchange_rate": exchangeRate,
        "global_currency_code": globalCurrencyCode,
        "base_currency_code": baseCurrencyCode,
        "channel_currency_code": channelCurrencyCode,
        "cart_currency_code": cartCurrencyCode,
        "grand_total": grandTotal,
        "formatted_grand_total": formattedGrandTotal,
        "base_grand_total": baseGrandTotal,
        "formatted_base_grand_total": formattedBaseGrandTotal,
        "sub_total": subTotal,
        "formatted_sub_total": formattedSubTotal,
        "base_sub_total": baseSubTotal,
        "formatted_base_sub_total": formattedBaseSubTotal,
        "tax_total": taxTotal,
        "formatted_tax_total": formattedTaxTotal,
        "base_tax_total": baseTaxTotal,
        "formatted_base_tax_total": formattedBaseTaxTotal,
        "discount": discount,
        "formatted_discount": formattedDiscount,
        "base_discount": baseDiscount,
        "formatted_base_discount": formattedBaseDiscount,
        "checkout_method": checkoutMethod,
        "is_guest": isGuest,
        "is_active": isActive,
        "conversion_time": conversionTime,
        "customer": customer,
        "channel": channel,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "selected_shipping_rate": selectedShippingRate,
        "payment": payment,
        "billing_address": billingAddress,
        "shipping_address": shippingAddress,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "taxes": taxes,
        "formatted_taxes": formattedTaxes,
        "base_taxes": baseTaxes,
        "formatted_base_taxes": formattedBaseTaxes,
        "formatted_discounted_sub_total": formattedDiscountedSubTotal,
        "formatted_base_discounted_sub_total": formattedBaseDiscountedSubTotal,
      };
}

class Item {
  int? id;
  int? quantity;
  String? sku;
  String? type;
  String? name;
  dynamic couponCode;
  String? weight;
  String? totalWeight;
  String? baseTotalWeight;
  String? price;
  String? formattedPrice;
  String? basePrice;
  String? formattedBasePrice;
  String? customPrice;
  String? formattedCustomPrice;
  String? total;
  String? formattedTotal;
  String? baseTotal;
  String? formattedBaseTotal;
  String? taxPercent;
  String? taxAmount;
  String? formattedTaxAmount;
  String? baseTaxAmount;
  String? formattedBaseTaxAmount;
  String? discountPercent;
  String? discountAmount;
  String? formattedDiscountAmount;
  String? baseDiscountAmount;
  String? formattedBaseDiscountAmount;
  List<AddOn>? addOns;
  int? sellerId;
  int? slotId;
  String? date;
  String? day;
  Vehicle? vehicle;
  Address? address;
  dynamic notes;
  dynamic child;
  String? companyLog;
  int? marketplaceProductId;
  Product? product;
  DateTime? createdAt;
  DateTime? updatedAt;

  Item({
    this.id,
    this.quantity,
    this.sku,
    this.type,
    this.name,
    this.couponCode,
    this.weight,
    this.totalWeight,
    this.baseTotalWeight,
    this.price,
    this.formattedPrice,
    this.basePrice,
    this.formattedBasePrice,
    this.customPrice,
    this.formattedCustomPrice,
    this.total,
    this.formattedTotal,
    this.baseTotal,
    this.formattedBaseTotal,
    this.taxPercent,
    this.taxAmount,
    this.formattedTaxAmount,
    this.baseTaxAmount,
    this.formattedBaseTaxAmount,
    this.discountPercent,
    this.discountAmount,
    this.formattedDiscountAmount,
    this.baseDiscountAmount,
    this.formattedBaseDiscountAmount,
    this.addOns,
    this.sellerId,
    this.slotId,
    this.date,
    this.day,
    this.vehicle,
    this.address,
    this.notes,
    this.child,
    this.companyLog,
    this.marketplaceProductId,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        quantity: json["quantity"],
        sku: json["sku"],
        type: json["type"],
        name: json["name"],
        couponCode: json["coupon_code"],
        weight: json["weight"],
        totalWeight: json["total_weight"],
        baseTotalWeight: json["base_total_weight"],
        price: json["price"],
        formattedPrice: json["formatted_price"],
        basePrice: json["base_price"],
        formattedBasePrice: json["formatted_base_price"],
        customPrice: json["custom_price"],
        formattedCustomPrice: json["formatted_custom_price"],
        total: json["total"],
        formattedTotal: json["formatted_total"],
        baseTotal: json["base_total"],
        formattedBaseTotal: json["formatted_base_total"],
        taxPercent: json["tax_percent"],
        taxAmount: json["tax_amount"],
        formattedTaxAmount: json["formatted_tax_amount"],
        baseTaxAmount: json["base_tax_amount"],
        formattedBaseTaxAmount: json["formatted_base_tax_amount"],
        discountPercent: json["discount_percent"],
        discountAmount: json["discount_amount"],
        formattedDiscountAmount: json["formatted_discount_amount"],
        baseDiscountAmount: json["base_discount_amount"],
        formattedBaseDiscountAmount: json["formatted_base_discount_amount"],
        addOns: json["add_ons"] == null
            ? []
            : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
        sellerId: json["seller_id"],
        slotId: json["slot_id"],
        date: json["date"],
        day: json["day"],
        vehicle:
            json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        notes: json["notes"],
        child: json["child"],
        companyLog: json["company_log"],
        marketplaceProductId: json["marketplace_product_id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "sku": sku,
        "type": type,
        "name": name,
        "coupon_code": couponCode,
        "weight": weight,
        "total_weight": totalWeight,
        "base_total_weight": baseTotalWeight,
        "price": price,
        "formatted_price": formattedPrice,
        "base_price": basePrice,
        "formatted_base_price": formattedBasePrice,
        "custom_price": customPrice,
        "formatted_custom_price": formattedCustomPrice,
        "total": total,
        "formatted_total": formattedTotal,
        "base_total": baseTotal,
        "formatted_base_total": formattedBaseTotal,
        "tax_percent": taxPercent,
        "tax_amount": taxAmount,
        "formatted_tax_amount": formattedTaxAmount,
        "base_tax_amount": baseTaxAmount,
        "formatted_base_tax_amount": formattedBaseTaxAmount,
        "discount_percent": discountPercent,
        "discount_amount": discountAmount,
        "formatted_discount_amount": formattedDiscountAmount,
        "base_discount_amount": baseDiscountAmount,
        "formatted_base_discount_amount": formattedBaseDiscountAmount,
        "add_ons": addOns == null
            ? []
            : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "seller_id": sellerId,
        "slot_id": slotId,
        "date": date,
        "day": day,
        "vehicle": vehicle?.toJson(),
        "address": address?.toJson(),
        "notes": notes,
        "child": child,
        "company_log": companyLog,
        "marketplace_product_id": marketplaceProductId,
        "product": product?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class AddOn {
  int? id;
  int? qty;
  String? name;
  double? price;

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
        price: json["price"]?.toDouble(),
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

class Product {
  int? id;
  String? sku;
  String? type;
  String? name;
  dynamic urlKey;
  String? price;
  String? formattedPrice;
  String? shortDescription;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;
  Reviews? reviews;

  Product({
    this.id,
    this.sku,
    this.type,
    this.name,
    this.urlKey,
    this.price,
    this.formattedPrice,
    this.shortDescription,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        sku: json["sku"],
        type: json["type"],
        name: json["name"],
        urlKey: json["url_key"],
        price: json["price"],
        formattedPrice: json["formatted_price"],
        shortDescription: json["short_description"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        reviews:
            json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "type": type,
        "name": name,
        "url_key": urlKey,
        "price": price,
        "formatted_price": formattedPrice,
        "short_description": shortDescription,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "reviews": reviews?.toJson(),
      };
}

class Reviews {
  int? total;
  int? totalRating;
  int? averageRating;
  List<dynamic>? percentage;

  Reviews({
    this.total,
    this.totalRating,
    this.averageRating,
    this.percentage,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        total: json["total"],
        totalRating: json["total_rating"],
        averageRating: json["average_rating"],
        percentage: json["percentage"] == null
            ? []
            : List<dynamic>.from(json["percentage"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "total_rating": totalRating,
        "average_rating": averageRating,
        "percentage": percentage == null
            ? []
            : List<dynamic>.from(percentage!.map((x) => x)),
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
