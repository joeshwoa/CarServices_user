// import 'package:autoflex/models/carModel.dart';
import 'dart:developer';

import 'package:autoflex/models/vehiclesModel.dart';
import 'package:autoflex/services/Home/vehiclesServices.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CarController extends GetxController {
  var car = Datum(name: 'Add Vehicle'.tr, plateNumber: 'Make & Model'.tr).obs;
  var cars = <Datum>[].obs;
  var loading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    if (Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
        .isLoggedIn
        .value) {
      await getVehiclesRequest();
    }
    if (cars.value.isNotEmpty) {
      car.value = cars[0];
    }
/*     cars.addAll([
      Datum(
        name: "SUV",
        id: 6,
        carType: Car(id: 1, name: "SUV", carBrandId: null),
        carBrand: CarBrand(id: 1, name: "Toyota"),
        carModel: Car(
          id: 1,
          name: "Camry",
        ),
        gearType: "auto",
        color: "blue",
        year: 2024,
        plateCode: "lol",
        plateNumber: "12345",
      )
    ]); */
  }

  Future<Vehicles?> getVehiclesRequest() async {
    try {
      loading.value = true;
      Vehicles? getVehiclesRequest = await VehiclesService.getVehicles();
      cars.value = getVehiclesRequest!.data!;
      if (cars.value.isEmpty) {
        car.value =
            Datum(name: 'Add Vehicle'.tr, plateNumber: 'Make & Model'.tr);
      } else {
        car.value = cars[0];
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

  void addCar(Datum car) {
    cars.add(car);
  }

  void updateCar(Datum newCar, String name) {
    int index = cars.value.indexWhere((car) => car.carType!.name == name);
    if (index != -1) {
      cars[index] = newCar;
    } else {
      print('Car with name ${newCar.carType!.name} not found.');
    }
  }

  void removeCar(String name) {
    int index = cars.value.indexWhere((car) => car.carType!.name == name);
    if (index != -1) {
      cars.removeAt(index);
    } else {
      if (kDebugMode) {
        print('Car with name $name not found.');
      }
    }
  }

  void changeCar(int id) {
    for (var selectedcar in cars) {
      if (selectedcar.id == id) {
        // selectedcar.name=name;
        car.value = selectedcar;
        print(car.value.id); // Update the observable car
        break; // Exit loop once the car is found and updated
      }
    }
  }
}
