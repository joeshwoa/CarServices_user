import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/addAddress.dart';
import 'package:autoflex/models/addressTypes.dart';
import 'package:autoflex/models/addresses.dart';
import 'package:autoflex/models/areas.dart';

import '../../shared/constants.dart';

class AddressService {
  static Future<AddressTypes?> getAddressTypes() async {
    var response = await Constants.getNetworkService(
        "v1/customer/addresses/types/all", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = addressTypesFromJson(response.body);

      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<Addresses?> getAddressesList() async {
    var response =
        await Constants.getNetworkService("v1/customer/addresses", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = addressesFromJson(response.body);

      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<AddAddress?> getAddress(addressId) async {
    var response = await Constants.getNetworkService(
        "v1/customer/addresses/$addressId", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = addAddressFromJson(response.body);

      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<Areas?> getAreas(id) async {
    var response = await Constants.getNetworkService(
        "v1/customer/addresses/area/$id", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = areasFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<AddAddress?> addNewAddress({
    String? buildingName,
    String? apartmentNo,
    String? parkingArea,
    String? customField,
    String? type,
    int? addressTypeId,
    int? emirateId,
    int? emirateCityId,
    String? address,
  }) async {
    var response = await Constants.postNetworkService(
        "v1/customer/addresses", "withToken", {
      "building_name": buildingName,
      "apartment_no": apartmentNo,
      "parking_area": parkingArea,
      "emirate_id": emirateId,
      "custom_field": customField,
      "type": type,
      "address_type_id": addressTypeId,
      "emirate_city_id": emirateCityId,
      "address": address
    });

    var result = addAddressFromJson(response.body);
    if (result != null) {
      print(response.body);
      return result;
    } else
      return null;
  }

  static Future<AddAddress?> editAddress({
    required int addressId,
    String? buildingName,
    String? apartmentNo,
    String? parkingArea,
    String? customField,
    String? type,
    int? addressTypeId,
    int? emirateId,
    int? emirateCityId,
    String? address,
  }) async {
    var response = await Constants.putNetworkService(
        "v1/customer/addresses/$addressId", "withToken", {
      "building_name": buildingName,
      "apartment_no": apartmentNo,
      "parking_area": parkingArea,
      "emirate_id": emirateId,
      "custom_field": customField,
      "type": type,
      "address_type_id": addressTypeId,
      "emirate_city_id": emirateCityId,
      "address": address
    });

    var result = addAddressFromJson(response.body);
    if (result != null) {
      print(response.body);
      return result;
    } else
      return null;
  }

  static Future<String?> deleteAddress({required int addressId}) async {
    var response = await Constants.deleteNetworkService(
        "v1/customer/addresses/$addressId", "withToken", {});
    var result = jsonDecode(response.body);
    if (result != null) {
      print(response.body);
      return result['message'];
    } else
      return null;
  }
}
