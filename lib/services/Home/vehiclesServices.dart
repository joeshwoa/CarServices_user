import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/carModel.dart' as Car;
import 'package:autoflex/models/vehicle.dart';
import 'package:autoflex/models/vehicleTypeBrandModel.dart';
import 'package:autoflex/models/vehiclesModel.dart';

import '../../shared/constants.dart';

class VehiclesService {
  static Future<Vehicles?> getVehicles() async {
    var response =
        await Constants.getNetworkService("v1/customer/vehicles", "withToken");
    inspect(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = vehiclesFromJson(response.body);

      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<Vehicle?> showVehicle(id) async {
    var response = await Constants.getNetworkService(
        "v1/customer/vehicles/$id", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = vehicleFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<VehicleTypeBrandModel?> getTypes() async {
    var response = await Constants.getNetworkService(
        "v1/customer/vehicles/types", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = vehicleTypeBrandModelFromJson(response.body);

      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<VehicleTypeBrandModel?> getBrands() async {
    var response = await Constants.getNetworkService(
        "v1/customer/vehicles/brands", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = vehicleTypeBrandModelFromJson(response.body);

      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<VehicleTypeBrandModel?> getModels(brandId) async {
    var response = await Constants.getNetworkService(
        "v1/customer/vehicles/models?brand=$brandId", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = vehicleTypeBrandModelFromJson(response.body);

      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<Vehicle?> addNewVehicle({
    int? carTypeId,
    int? carBrandId,
    int? carModelId,
    int? emirateId,
    int? year,
    String? gearType,
    String? color,
    String? plateCode,
    String? plateNumber,
  }) async {
    print(carTypeId);
    print(carBrandId);
    print(carModelId);

    print(year);
    print(emirateId);
    print(gearType);
    print(plateCode);
    print(plateNumber);
    print(color);
    var response = await Constants.postNetworkService(
        "v1/customer/vehicles", "withToken", {
      "car_type_id": carTypeId,
      "car_brand_id": carBrandId,
      "car_model_id": carModelId,
      "emirate_id": emirateId,
      "gear_type": gearType,
      "color": color,
      "year": year,
      "plate_code": plateCode,
      "plate_number": plateNumber
    });

    var result = vehicleFromJson(response.body);
    if (result != null) {
      print(response.body);
      return result;
    } else
      return null;
  }

  static Future<Vehicle?> updateVehicle({
    required int carId,
    int? carTypeId,
    int? carBrandId,
    int? carModelId,
    int? emirateId,
    int? year,
    String? gearType,
    String? color,
    String? plateCode,
    String? plateNumber,
  }) async {
    print(carTypeId);
    print(carBrandId);
    print(carModelId);

    print(year);
    print(emirateId);
    print(gearType);
    print(plateCode);
    print(plateNumber);
    print(color);
    var response = await Constants.putNetworkService(
        "v1/customer/vehicles/$carId", "withToken", {
      "car_type_id": carTypeId,
      "car_brand_id": carBrandId,
      "car_model_id": carModelId,
      "emirate_id": emirateId,
      "gear_type": gearType,
      "color": color,
      "year": year,
      "plate_code": plateCode,
      "plate_number": plateNumber
    });

    var result = vehicleFromJson(response.body);
    if (result != null) {
      print(response.body);
      return result;
    } else
      return null;
  }

  static Future<String?> deleteVehicle(int carId) async {
    var response = await Constants.deleteNetworkService(
        "v1/customer/vehicles/$carId", "withToken", {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = jsonDecode(response.body);
      if (result != null) {
        return result['message'];
      }
    } else {
      return null;
    }
  }
}
