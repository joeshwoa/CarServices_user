// To parse this JSON data, do
//
//     final invoice = invoiceFromJson(jsonString);

import 'dart:convert';

Invoice invoiceFromJson(String str) => Invoice.fromJson(json.decode(str));

String invoiceToJson(Invoice data) => json.encode(data.toJson());

class Invoice {
  Data? data;

  Invoice({
    this.data,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  dynamic state;
  int? emailSent;
  int? totalQty;
  String? baseCurrencyCode;
  String? channelCurrencyCode;
  String? orderCurrencyCode;
  String? subTotal;
  String? formattedSubTotal;
  String? baseSubTotal;
  String? formattedBaseSubTotal;
  String? grandTotal;
  String? formattedGrandTotal;
  String? baseGrandTotal;
  String? formattedBaseGrandTotal;
  String? shippingAmount;
  String? formattedShippingAmount;
  String? baseShippingAmount;
  String? formattedBaseShippingAmount;
  String? taxAmount;
  String? formattedTaxAmount;
  String? baseTaxAmount;
  String? formattedBaseTaxAmount;
  String? discountAmount;
  String? formattedDiscountAmount;
  String? baseDiscountAmount;
  String? formattedBaseDiscountAmount;
  dynamic orderAddress;
  dynamic transactionId;
  String? paymentMethod;
  List<Item>? items;
  DateTime? createdAt;

  Data({
    this.id,
    this.state,
    this.emailSent,
    this.totalQty,
    this.baseCurrencyCode,
    this.channelCurrencyCode,
    this.orderCurrencyCode,
    this.subTotal,
    this.formattedSubTotal,
    this.baseSubTotal,
    this.formattedBaseSubTotal,
    this.grandTotal,
    this.formattedGrandTotal,
    this.baseGrandTotal,
    this.formattedBaseGrandTotal,
    this.shippingAmount,
    this.formattedShippingAmount,
    this.baseShippingAmount,
    this.formattedBaseShippingAmount,
    this.taxAmount,
    this.formattedTaxAmount,
    this.baseTaxAmount,
    this.formattedBaseTaxAmount,
    this.discountAmount,
    this.formattedDiscountAmount,
    this.baseDiscountAmount,
    this.formattedBaseDiscountAmount,
    this.orderAddress,
    this.transactionId,
    this.paymentMethod,
    this.items,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    state: json["state"],
    emailSent: json["email_sent"],
    totalQty: json["total_qty"],
    baseCurrencyCode: json["base_currency_code"],
    channelCurrencyCode: json["channel_currency_code"],
    orderCurrencyCode: json["order_currency_code"],
    subTotal: json["sub_total"],
    formattedSubTotal: json["formatted_sub_total"],
    baseSubTotal: json["base_sub_total"],
    formattedBaseSubTotal: json["formatted_base_sub_total"],
    grandTotal: json["grand_total"],
    formattedGrandTotal: json["formatted_grand_total"],
    baseGrandTotal: json["base_grand_total"],
    formattedBaseGrandTotal: json["formatted_base_grand_total"],
    shippingAmount: json["shipping_amount"],
    formattedShippingAmount: json["formatted_shipping_amount"],
    baseShippingAmount: json["base_shipping_amount"],
    formattedBaseShippingAmount: json["formatted_base_shipping_amount"],
    taxAmount: json["tax_amount"],
    formattedTaxAmount: json["formatted_tax_amount"],
    baseTaxAmount: json["base_tax_amount"],
    formattedBaseTaxAmount: json["formatted_base_tax_amount"],
    discountAmount: json["discount_amount"],
    formattedDiscountAmount: json["formatted_discount_amount"],
    baseDiscountAmount: json["base_discount_amount"],
    formattedBaseDiscountAmount: json["formatted_base_discount_amount"],
    orderAddress: json["order_address"],
    transactionId: json["transaction_id"],
    paymentMethod: json["payment_method"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state": state,
    "email_sent": emailSent,
    "total_qty": totalQty,
    "base_currency_code": baseCurrencyCode,
    "channel_currency_code": channelCurrencyCode,
    "order_currency_code": orderCurrencyCode,
    "sub_total": subTotal,
    "formatted_sub_total": formattedSubTotal,
    "base_sub_total": baseSubTotal,
    "formatted_base_sub_total": formattedBaseSubTotal,
    "grand_total": grandTotal,
    "formatted_grand_total": formattedGrandTotal,
    "base_grand_total": baseGrandTotal,
    "formatted_base_grand_total": formattedBaseGrandTotal,
    "shipping_amount": shippingAmount,
    "formatted_shipping_amount": formattedShippingAmount,
    "base_shipping_amount": baseShippingAmount,
    "formatted_base_shipping_amount": formattedBaseShippingAmount,
    "tax_amount": taxAmount,
    "formatted_tax_amount": formattedTaxAmount,
    "base_tax_amount": baseTaxAmount,
    "formatted_base_tax_amount": formattedBaseTaxAmount,
    "discount_amount": discountAmount,
    "formatted_discount_amount": formattedDiscountAmount,
    "base_discount_amount": baseDiscountAmount,
    "formatted_base_discount_amount": formattedBaseDiscountAmount,
    "order_address": orderAddress,
    "transaction_id": transactionId,
    "payment_method": paymentMethod,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
  };
}

class Item {
  int? id;
  String? name;
  int? qty;
  String? price;
  String? formattedPrice;
  int? total;
  String? formattedTotal;
  int? taxAmount;
  String? formattedTaxAmount;
  int? grandTotal;
  String? formattedGrandTotal;
  List<AddOn>? addOns;
  String? day;
  DateTime? date;
  int? slotId;

  Item({
    this.id,
    this.name,
    this.qty,
    this.price,
    this.formattedPrice,
    this.total,
    this.formattedTotal,
    this.taxAmount,
    this.formattedTaxAmount,
    this.grandTotal,
    this.formattedGrandTotal,
    this.addOns,
    this.day,
    this.date,
    this.slotId,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    qty: json["qty"],
    price: json["price"],
    formattedPrice: json["formatted_price"],
    total: json["total"],
    formattedTotal: json["formatted_total"],
    taxAmount: json["tax_amount"],
    formattedTaxAmount: json["formatted_tax_amount"],
    grandTotal: json["grand_total"],
    formattedGrandTotal: json["formatted_grand_total"],
    addOns: json["add_ons"] == null ? [] : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
    day: json["day"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    slotId: json["slot_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "qty": qty,
    "price": price,
    "formatted_price": formattedPrice,
    "total": total,
    "formatted_total": formattedTotal,
    "tax_amount": taxAmount,
    "formatted_tax_amount": formattedTaxAmount,
    "grand_total": grandTotal,
    "formatted_grand_total": formattedGrandTotal,
    "add_ons": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x.toJson())),
    "day": day,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "slot_id": slotId,
  };
}

class AddOn {
  int? id;
  String? name;
  int? qty;
  int? price;
  String? formattedPrice;
  int? total;
  String? formattedTotal;
  double? taxAmount;
  String? formattedTaxAmount;
  double? grandTotal;
  String? formattedGrandTotal;

  AddOn({
    this.id,
    this.name,
    this.qty,
    this.price,
    this.formattedPrice,
    this.total,
    this.formattedTotal,
    this.taxAmount,
    this.formattedTaxAmount,
    this.grandTotal,
    this.formattedGrandTotal,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
    id: json["id"],
    name: json["name"],
    qty: json["qty"],
    price: json["price"],
    formattedPrice: json["formatted_price"],
    total: json["total"],
    formattedTotal: json["formatted_total"],
    taxAmount: json["tax_amount"]?.toDouble(),
    formattedTaxAmount: json["formatted_tax_amount"],
    grandTotal: json["grand_total"]?.toDouble(),
    formattedGrandTotal: json["formatted_grand_total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "qty": qty,
    "price": price,
    "formatted_price": formattedPrice,
    "total": total,
    "formatted_total": formattedTotal,
    "tax_amount": taxAmount,
    "formatted_tax_amount": formattedTaxAmount,
    "grand_total": grandTotal,
    "formatted_grand_total": formattedGrandTotal,
  };
}
