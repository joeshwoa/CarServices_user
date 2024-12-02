import 'package:autoflex/models/item_model.dart';

class Order extends Item {
  String? status;

  Order({
    String? id,
    String? name,
    String? date,
    double? price,
    String? providerLogo,
    String? car,
    List<AddOn>? addOns,
    List<String>? notes,
    this.status,
  }) : super(
          id: id,
          name: name,
          date: date,
          price: price,
          providerLogo: providerLogo,
          car: car,
          addOns: addOns,
          notes: notes,
        );

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      name: json["name"],
      date: json["date"],
      price: json["price"],
      providerLogo: json["providerLogo"],
      car: json["car"],
      addOns: json["add-ons"] == null
          ? []
          : List<AddOn>.from(json["add-ons"]!.map((x) => AddOn.fromJson(x))),
      notes: json["notes"] == null
          ? []
          : List<String>.from(json["notes"]!.map((x) => x)),
      status: json["status"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["status"] = status;
    return data;
  }
}
