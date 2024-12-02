import 'dart:developer';

import 'package:autoflex/models/addAddress.dart';
import 'package:autoflex/models/addresses.dart';
import 'package:autoflex/models/locationModel.dart';
import 'package:autoflex/services/Home/addressServices.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/locations/addLocation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var location =
      Datum(address: 'Area, Emirate'.tr, type: 'Add Location'.tr).obs;
  var locations = <Datum>[].obs;
  var loading = false.obs;
  /* var myLocations = <Datum>[].obs; */

  @override
  Future<void> onInit() async {
    super.onInit();
    if (Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
        .isLoggedIn
        .value) {
      await getLoacationsRequest();
    }
    if (locations.value.isNotEmpty) {
      location.value = locations[0];
    }
    /* locations.addAll([
      Location(location: 'earth, home', type: 'home'),
      Location(location: 'earth, work', type: 'work'),
      Location(location: 'earth, other', type: 'other')
    ]); */
  }

  Future<Addresses?> getLoacationsRequest() async {
    try {
      loading.value = true;
      Addresses? getLoacationsRequest = await AddressService.getAddressesList();
      locations.value = getLoacationsRequest!.data!;
      if (locations.value.isEmpty) {
        location.value =
            Datum(address: 'Area, Emirate'.tr, type: 'Add Location'.tr);
      } else {
        location.value = locations[0];
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

  /* void selectLocation(int locationId) {
    for (var _location in myLocations) {
      if (_location.id == locationId) {
        location.value = _location;
      }
    }
  } */

  /* Future<Addresses?> getLocationsListRequest() async {
    try {
      loading.value = true;
      Addresses? getLocationsListRequest =
          await AddressService.getAddressesList();
      myLocations.value = getLocationsListRequest!.data!;
      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  } */

  editLocation() {
    Get.to(() => AddLocationScreen(),
        arguments: {'type': 'edit', 'LocationId': location.value!.id});
  }

  void changelocation(int id) {
    for (var location in locations) {
      if (location.id == id) {
        this.location.value = location; // Update the observable location
        break;
      }
    }
  }
}
