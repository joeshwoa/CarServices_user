class Item {
  String? id;
  String? name;
  String? date;
  double? price;
  String? providerLogo;
  String? car; // New property
  List<AddOn>? addOns;
  List<String>? notes;

  Item({
    this.id,
    this.name,
    this.date,
    this.price,
    this.providerLogo,
    this.car, // New property
    this.addOns,
    this.notes,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        date: json["date"],
        price: json["price"],
        providerLogo: json["providerLogo"],
        car: json["car"], // New property
        addOns: json["add-ons"] == null
            ? []
            : List<AddOn>.from(json["add-ons"]!.map((x) => AddOn.fromJson(x))),
        notes: json["notes"] == null
            ? []
            : List<String>.from(json["notes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "price": price,
        "providerLogo": providerLogo,
        "car": car, // New property
        "add-ons": addOns == null
            ? []
            : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x)),
      };
}

class AddOn {
  String? name;
  double? price;

  AddOn({
    this.name,
    this.price,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}
