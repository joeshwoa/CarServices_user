import 'dart:developer';

import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/models/cartItem.dart';
// import 'package:autoflex/models/item_model.dart';
import 'package:autoflex/services/Home/cartServices.dart';
import 'package:autoflex/shared/components/cart_item.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/cart_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'provider_controller.dart';

class CartController extends GetxController {
  //  final providerController = Get.put(ProviderController());
  final locationController = Get.find<LocationController>();
  var cart = <Item>[].obs;
  var loading = false.obs;
  var total = 0.0.obs;
  var add_ons = <AddOn>[].obs;
  var disabledAddOns = RxSet();
  var boughtAddOns = <AddOn>[].obs;
  var grandTotal = 0.0.obs;
  var totalTax = 0.0.obs;
  var taxRate = 0.0.obs;
  var notesControllers = [].obs;
  var slots = [
    {"id": 1, "from": "12 AM", "to": "1 AM"},
    {"id": 2, "from": "1 AM", "to": "2 AM"},
    {"id": 3, "from": "2 AM", "to": "3 AM"},
    {"id": 4, "from": "3 AM", "to": "4 AM"},
    {"id": 5, "from": "4 AM", "to": "5 AM"},
    {"id": 6, "from": "5 AM", "to": "6 AM"},
    {"id": 7, "from": "6 AM", "to": "7 AM"},
    {"id": 8, "from": "7 AM", "to": "8 AM"},
    {"id": 9, "from": "8 AM", "to": "9 AM"},
    {"id": 10, "from": "9 AM", "to": "10 AM"},
    {"id": 11, "from": "10 AM", "to": "11 AM"},
    {"id": 12, "from": "11 AM", "to": "12 PM"},
    {"id": 13, "from": "12 PM", "to": "1 PM"},
    {"id": 14, "from": "1 PM", "to": "2 PM"},
    {"id": 15, "from": "2 PM", "to": "3 PM"},
    {"id": 16, "from": "3 PM", "to": "4 PM"},
    {"id": 17, "from": "4 PM", "to": "5 PM"},
    {"id": 18, "from": "5 PM", "to": "6 PM"},
    {"id": 19, "from": "6 PM", "to": "7 PM"},
    {"id": 20, "from": "7 PM", "to": "8 PM"},
    {"id": 21, "from": "8 PM", "to": "9 PM"},
    {"id": 22, "from": "9 PM", "to": "10 PM"},
    {"id": 23, "from": "10 PM", "to": "11 PM"},
    {"id": 24, "from": "11 PM", "to": "12 AM"}
  ];

  // double get total => cart.fold(
  //     0,
  //     (sum, item) =>
  //         sum +
  //         item.price! +
  //         item.addOns!.fold(0, (sum, addOn) => sum + addOn.price!));

  @override
  Future<void> onInit() async {
    super.onInit();
    if (Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
        .isLoggedIn
        .value) {
      await getCartListRequest();
    }
    for (var i = 0; i < cart.length; i++) {
      notesControllers.add(TextEditingController());
    }
  }

  Future<AddCartItem?> getCartListRequest() async {
    try {
      loading.value = true;
      AddCartItem? getCartListRequest = await CartService.getCartList();
      cart.value = getCartListRequest!.data!.items!;
      grandTotal.value = (getCartListRequest.data!.subTotal as int).toDouble();
      totalTax.value = getCartListRequest.data!.taxTotal!;
      if (cart.isEmpty) {
        //remove old controllers when user checksout or deletes all items
        notesControllers.clear();
      }

      //if a new item is added add a new controller
      if (cart.length - notesControllers.length > 0) {
        for (var i = cart.length - notesControllers.length;
            i < cart.length - notesControllers.length + 1;
            i++) {
          notesControllers.add(TextEditingController());
        }
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  addToCartRequest(productId, carId, carTypeId, date, day, slotId) async {
    print("typeId" + carTypeId.toString());
    try {
      loading.value = true;

      AddCartItem? addToCartRequest = await CartService.addNewIem(
          quantity: 1,
          productId: productId,
          date: date.toString(),
          slotId: slotId,
          addressId: locationController.location.value.id!,
          day: day,
          vehicleId: carId,
          carTypeId: carTypeId,
          //  addOns: []
          addOns: boughtAddOns);
      // return '';
      if (addToCartRequest!.message == 'Item is successfully added to cart.' ||
          addToCartRequest!.message!.contains('بنجاح')) {
        loading.value = false;
        toast(message: addToCartRequest.message.toString());
        await getCartListRequest();
        disabledAddOns.clear();
        boughtAddOns.clear();
        Get.to(() => CartScreen());
        return "registered successfully";
      } else {
        loading.value = false;
        return addToCartRequest.message;
      }
      // }
    } catch (e) {
      if (kDebugMode) {
        loading.value = false;
        print(e);
      }
    }
  }

  // Method to add a new provider to the list
  void addItem(Item item) {
    cart.add(item);
  }

  // Method to delete an item from the cart
  Future<void> deleteItem(String id) async {
    cart.removeWhere((item) {
      return item.id == int.parse(id);
    });
    AddCartItem? deleteItemRequest = await CartService.deleteItem(id);
    await getCartListRequest();
    inspect(cart.value);
    inspect(notesControllers.value);
  }

  // Method to add a note to an item's notes array
  // void addNote(Item item, String note) {
  //   item.notes ??= [];
  //   item.notes!.add(note);
  // }

  // Method to delete an add-on from an item's add-ons list
  Future<String?> deleteAddOn(
      {required int addOnId, required int itemId}) async {
    loading.value = true;
    AddCartItem? deleteAddOnRequest =
        await CartService.deleteAddOn(addOnId, itemId);
    if (deleteAddOnRequest!.message ==
            'Item is successfully removed from the cart.' ||
        deleteAddOnRequest!.message!.contains('بنجاح')) {
      loading.value = false;
      toast(message: deleteAddOnRequest.message.toString());
      await getCartListRequest();
      return "deleted successfully";
    } else {
      loading.value = false;
      return deleteAddOnRequest.message;
    }
  }

  Future<String?> addNote({required int itemId, required String notes}) async {
    AddCartItem? addNoteRequest =
        await CartService.AddNote(itemId: itemId, notes: notes);
    if (addNoteRequest!.message == 'Cart Item(s) successfully updated.' ||
        addNoteRequest!.message!.contains('بنجاح')) {
      print('noted');
      loading.value = false;
      toast(message: addNoteRequest.message.toString());
      await getCartListRequest();
      return "added successfully";
    } else {
      loading.value = false;
      return addNoteRequest.message;
    }
  }

  void emptyCart() {
    cart.clear();
  }
}
