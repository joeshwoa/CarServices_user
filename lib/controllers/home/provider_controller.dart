import 'dart:developer';

import 'package:autoflex/models/item_model.dart';
import 'package:autoflex/models/provider_model.dart';
import 'package:autoflex/models/sellerProduct.dart';
import 'package:autoflex/models/sellers.dart';
import 'package:autoflex/models/wishlistItem.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/Home/sellersService.dart';

class ProviderController extends GetxController {
  var providers = <Datum>[].obs;
  var seeMore = false.obs;
  var loading = false.obs;
  var selectedProductId = 1.obs;
  var productDetails = Data().obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Replace with api call
    // providers.addAll([
    //   Provider(
    //     isPromoted: true,
    //     logo: "assets/images/providerLogo.png",
    //     name: "kleenecar",
    //     favourited: false,
    //     services: [
    //       Service(
    //         name: "wash",
    //         price: 45.00,
    //         addOns: [
    //           AddOn(name: "wax", price: 5.00),
    //           AddOn(name: "body polish", price: 5.00),
    //         ],
    //         description: [
    //           "Interior Vacuum, Dust wiping & cleaning",
    //           "Full car body wash",
    //           "Light interior shining with special products and fragrance",
    //           "Tires and wheels wash and shine"
    //         ],
    //         details: [
    //           "Wax, Trash bag, Tissue pack, Perfuming, Floor mats casing",
    //           "No power outlet required",
    //           "Duration: 1 HOUR"
    //         ],
    //       ),
    //       Service(
    //         name: "premium wash",
    //         price: 45.00,
    //         addOns: [],
    //         description: [
    //           "Interior Vacuum, Dust wiping & cleaning",
    //           "Full car body wash",
    //           "Light interior shining with special products and fragrance",
    //           "Tires and wheels wash and shine"
    //         ],
    //         details: [
    //           "Wax, Trash bag, Tissue pack, Perfuming, Floor mats casing",
    //           "No power outlet required",
    //           "Duration: 1 HOUR"
    //         ],
    //       ),
    //       Service(
    //         name: "detailing",
    //         price: 45.00,
    //         addOns: [
    //           AddOn(name: "wax", price: 5.00),
    //           AddOn(name: "body polish", price: 5.00),
    //         ],
    //         description: [
    //           "Interior Vacuum, Dust wiping & cleaning",
    //           "Full car body wash"
    //         ],
    //         details: [
    //           "Wax, Trash bag, Tissue pack, Perfuming, Floor mats casing",
    //           "No power outlet required",
    //           "Duration: 1 HOUR"
    //         ],
    //       ),
    //     ],
    //     votes: 198,
    //     rating: 4.5,
    //   ),
    //   Provider(
    //     isPromoted: true,
    //     logo: "assets/images/providerLogo2.png",
    //     name: "auto wash",
    //     favourited: true,
    //     services: [
    //       Service(
    //         name: "wash",
    //         price: 45.00,
    //         addOns: [],
    //         description: [
    //           "Interior Vacuum, Dust wiping & cleaning",
    //           "Full car body wash",
    //           "Light interior shining with special products and fragrance",
    //           "Tires and wheels wash and shine"
    //         ],
    //         details: [
    //           "Wax, Trash bag, Tissue pack, Perfuming, Floor mats casing",
    //           "No power outlet required",
    //           "Duration: 1 HOUR"
    //         ],
    //       ),
    //       Service(
    //         name: "premium wash",
    //         price: 45.00,
    //         addOns: [
    //           AddOn(name: "wax", price: 5.00),
    //           AddOn(name: "body polish", price: 5.00),
    //         ],
    //         description: [
    //           "Interior Vacuum, Dust wiping & cleaning",
    //           "Full car body wash"
    //         ],
    //         details: [
    //           "Wax, Trash bag, Tissue pack, Perfuming, Floor mats casing",
    //           "No power outlet required",
    //           "Duration: 1 HOUR"
    //         ],
    //       ),
    //     ],
    //     votes: 50,
    //     rating: 4,
    //   )
    // ]);
    getSellersRequest("");
  }

  Future<Sellers?> getSellersRequest(keyword) async {
    try {
      loading.value = true;
      Sellers? getSellersRequest = await SellersService.getSellers(
          Get.arguments['categoryId'],
          Get.arguments['cityId'],
          Get.arguments['slotId'],
          Get.arguments['day'],
          Get.arguments['date'],
          Get.arguments['car_type_id'],
          keyword);
      providers.value = getSellersRequest!.data!;

      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<SellerProduct?> getProductDetailsRequest() async {
    try {
      loading.value = true;
      SellerProduct? getProductDetailsRequest =
          await SellersService.getProductDetails(selectedProductId.value);
      productDetails.value = getProductDetailsRequest!.data!;
      print('details');
      inspect(productDetails.value);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  // Method to add a new provider to the list
  void addProvider(Datum provider) {
    providers.add(provider);
  }

  // Method to update provider's votes
  void updateProviderVotes(String providerName, int newVotes) {
    int index =
        providers.indexWhere((provider) => provider.name == providerName);
    if (index != -1) {
      providers[index].votes = newVotes;
      providers.refresh();
    }
  }

  // Method to update provider's rating
  void updateProviderRating(String providerName, double newRating) {
    int index =
        providers.indexWhere((provider) => provider.name == providerName);
    if (index != -1) {
      providers[index].rating = newRating;
      providers.refresh();
    }
  }

  // Method to update provider's favourited status
  void updateProviderFavourited(int id) async {
//  loading.value = true;
    WishlistItem? updateProviderFavouritedRequest =
        await SellersService.favouriteSeller(id);
    getSellersRequest(searchController.text);
    toast(message: updateProviderFavouritedRequest!.message!);
  }
}
