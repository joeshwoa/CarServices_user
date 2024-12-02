/* import 'dart:developer';

import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/models/addAddress.dart';
import 'package:autoflex/models/addresses.dart';
import 'package:autoflex/services/Home/addressServices.dart';
import 'package:autoflex/views/locations/addLocation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MyLocationsController extends GetxController {
  var myLocations = <Datum>[].obs;
  var loading = false.obs;
  var selectedLocation = Rx<Datum?>(null);

  void onInit() async {
    super.onInit();
    await getLocationsListRequest();
    myLocations.length > 0 ? selectedLocation.value = myLocations[0] : {};
  }

  void selectLocation(int locationId) {
    for (var location in myLocations) {
      if (location.id == locationId) {
        selectedLocation.value = location;
      }
    }
  }

  Future<Addresses?> getLocationsListRequest() async {
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
  }

  editLocation() {
    Get.to(() => AddLocationScreen(),
        arguments: {'type': 'edit', 'LocationId': selectedLocation.value!.id});
  }
} */
