// To parse this JSON data, do
//
//     final wishlistItem = wishlistItemFromJson(jsonString);

import 'dart:convert';

WishlistItem wishlistItemFromJson(String str) => WishlistItem.fromJson(json.decode(str));

String wishlistItemToJson(WishlistItem data) => json.encode(data.toJson());

class WishlistItem {
    String? message;

    WishlistItem({
        this.message,
    });

    factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
