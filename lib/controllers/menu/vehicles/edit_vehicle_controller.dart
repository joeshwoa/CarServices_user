import 'package:autoflex/models/vehicle.dart';
import 'package:autoflex/models/vehiclesModel.dart';
import 'package:autoflex/services/Home/vehiclesServices.dart';
import 'package:autoflex/views/vehicles/add_vehicles_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'dart:developer';

class EditVehicleController extends GetxController {
  var loading = false.obs;
  var vehicle = Vehicle().obs;
  var populated = false.obs;

  editVehicleRequest(id) async {
    try {
      loading.value = true;
      Vehicle? getVehicleRequest = await VehiclesService.showVehicle(id);
      loading.value = false;
      vehicle.value = getVehicleRequest!;
      inspect(vehicle.value);
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
