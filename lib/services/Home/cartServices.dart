import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/cartItem.dart';
import 'package:autoflex/shared/components/cart_item.dart';

import '../../shared/constants.dart';

class CartService {
  static Future<AddCartItem?> getCartList() async {
    var response =
        await Constants.getNetworkService("v1/customer/cart", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = addCartItemFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<AddCartItem?> deleteItem(id) async {
    var response = await Constants.deleteNetworkService(
        "v1/customer/cart/remove/$id", "withToken", {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = addCartItemFromJson(response.body);

      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<AddCartItem?> deleteAddOn(itemId, addOnId) async {
    var response = await Constants.deleteNetworkService(
        "v1/customer/cart/remove/$addOnId/add_ons/$itemId", "withToken", {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = addCartItemFromJson(response.body);
      inspect(result);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<AddCartItem?> addNewIem({
    required dynamic productId,
    required dynamic quantity,
    required dynamic addOns,
    required String date,
    required int addressId,
    required int slotId,
    required String day,
    required int vehicleId,
    required int carTypeId,
  }) async {
    var response = await Constants.postNetworkService(
        "v1/customer/cart/add/$productId", "withToken", {
      "product_id": productId,
      "quantity": quantity,
      "add_ons": addOns,
      "date": date,
      "slot_id": slotId,
      "day": day,
      "vehicle_id": vehicleId,
      "car_type_id":carTypeId,
      "address_id": addressId,
    });
    print(productId);
    print(quantity);
    print(addOns);
    print(date);
    print(slotId);
    print(day);
    print(vehicleId);
    print(carTypeId);
    print(addressId);
    
    var result = addCartItemFromJson(response.body);
    print(response.body);
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<AddCartItem?> savePayment({required String method}) async {
    var response = await Constants.postNetworkService(
        "v1/customer/checkout/save-payment", "withToken", {
      "payment": {"method": method}
    });
    print('hello');
    inspect(response.body);
    var result = addCartItemFromJson(response.body);
    // inspect(result);
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<AddCartItem?> checkout({required String method}) async {
    var response = await Constants.postNetworkService(
        "v1/customer/checkout/save-order", "withToken", {
      "payment": {"method": method}
    });
    print('hi');
    print(response.body);
    var result = addCartItemFromJson(response.body);
    inspect(result);
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<AddCartItem?> AddNote({
    required String notes,
    required int itemId,
  }) async {
    var response = await Constants.putNetworkService(
        "v1/customer/cart/update", "withToken", {
      "qty": {"$itemId": 1},
      "notes": {"$itemId": notes}
    });
    var result = addCartItemFromJson(response.body);
    inspect(result);
    if (result != null) {
      return result;
    } else
      return null;
  }
}
