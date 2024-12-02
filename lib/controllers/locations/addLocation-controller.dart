import 'dart:developer';
import 'dart:ffi';
import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/controllers/locations/myLocations-controller.dart';
import 'package:autoflex/models/addressTypes.dart';
import 'package:autoflex/models/areas.dart';
import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:autoflex/models/addresses.dart' as addresses;
import '../../models/addAddress.dart';
import '../../services/Home/addressServices.dart';

class AddLocationController extends GetxController {
  final addLocationFormKey = GlobalKey<FormState>();
  final locationController = Get.find<LocationController>();
  var expansionControllers = [
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
  ].obs;
  var expandedIndex = (-1).obs;
  changeExpanded(index) {
    if (expandedIndex.value == index) {
      expansionControllers[expandedIndex.value]
          .collapse(); // Collapse the tile if it's already expanded
      expandedIndex.value = -1; // Collapse all tiles
    } else {
      if (expandedIndex.value != -1) {
        expansionControllers[expandedIndex.value]
            .collapse(); // Collapse the previously expanded tile
      }
      expandedIndex.value = index;
      expansionControllers[expandedIndex.value]
          .expand(); // Expand the clicked tile
    }
    refresh();
  }

  Map<String, String> LocationTypesISO = {
    "العمل": "Work",
    "المنزل": "Home",
    "أخرى": "Other",
    "شقة": "Apartment",
    "فيلا": "Villa",
  };
  var errorMessage = ''.obs;
  var selectedLocation = Rx<Data>(Data());
  var loading = false.obs;
  var areas = <Area>[].obs;
  var originalAreas = <Area>[].obs;

  var parkingAreas = [
    'Inside Building '.tr,
    'Outside Building / Public Parking'.tr,
  ].obs;
  var emirates = [
    {'id': 1, "name": 'Abu Dhabi'.tr},
    {'id': 2, "name": 'Dubai'.tr},
    {'id': 3, "name": 'Sharjah'.tr},
    {'id': 4, "name": 'Ajman'.tr},
    {'id': 5, "name": 'Umm Al Quwain'.tr},
    {'id': 6, "name": 'Ras Al Khaimah'.tr},
    {'id': 7, "name": 'Fujairah'.tr}
  ].obs;
  var selectedEmirate = ''.obs;
  var selectedArea = ''.obs;
  var selectedParkingArea = ''.obs;
  var locationTypes = <Datum>[].obs;
  var selectedLocationType = ''.obs;
  var selectedLocationSubTypes = <Child>[].obs;
  var selectedsubType = ''.obs;
  var selectedEmirateId = 0.obs;
  var selectedAreaId = 0.obs;
  TextEditingController villaNumberController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController aditionalInformationController =
      TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    await getTypesRequest();
    if (Get.arguments['type'] == 'add') {
      selectedLocationType.value = locationTypes[0].type!;
      selectedLocationSubTypes.value = locationTypes[0].children!;
      selectedsubType.value = selectedLocationSubTypes[0].type!;
    } else {
      await getLocationRequest();
      await getEmriteAreas(selectedLocation.value.emirate!.id!);
      //after populating the emrite we select the area to populate it's field
      selectArea(Area(
          name: selectedLocation.value.emirateCity?.name ?? '',
          id: selectedLocation.value.emirateCity!.id!));
      selectedLocationSubTypes.value = selectedLocation.value.type == 'Home'
          ? locationTypes[0].children!
          : [];
      selectedLocationType.value = selectedLocation.value.type ?? '';
      selectedsubType.value = selectedLocation.value.type == 'Home'
          ? selectedLocationSubTypes[0].type!
          : '';
      selectedEmirate.value = selectedLocation.value.emirate?.name ?? '';
      selectedEmirateId.value = selectedLocation.value.emirate!.id!;
      selectedParkingArea.value = selectedLocation.value.parkingArea ?? '';
      villaNumberController.text = selectedLocation.value.apartmentNo ?? '';
      streetController.text = selectedLocation.value.address ?? '';
      aditionalInformationController.text =
          selectedLocation.value.customField ?? '';
      buildingNameController.text = selectedLocation.value.buildingName ?? '';
      apartmentNumberController.text = selectedLocation.value.apartmentNo ?? '';
    }
  }

  checkValidation() {
    final isValid = addLocationFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  Future<AddressTypes?> getTypesRequest() async {
    try {
      loading.value = true;
      AddressTypes? getTypesRequest = await AddressService.getAddressTypes();
      locationTypes.value = getTypesRequest!.data!;
      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  areaSearch(keyword) {
    if (keyword.isEmpty) {
      areas.value = List.from(originalAreas.value);
    } else {
      areas.value =
          originalAreas.where((area) => area.name!.contains(keyword)).toList();
    }
  }

  Future<AddressTypes?> getEmriteAreas(id) async {
    try {
      loading.value = true;
      Areas? getTypesRequest = await AddressService.getAreas(id);
      areas.value = getTypesRequest!.data!;
      originalAreas.value = getTypesRequest!.data!;
      areas.refresh();
      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<AddAddress?> getLocationRequest() async {
    try {
      loading.value = true;
      AddAddress? getLocationRequest =
          await AddressService.getAddress(Get.arguments['LocationId']);
      selectedLocation.value = getLocationRequest!.data!;
      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  void changeLocationType(String _location) {
    for (var locationType in locationTypes) {
      if (locationType.type == _location) {
        selectedLocationType.value = locationType.type!;
        selectedLocation.value.addressTypeId = locationType.id;
        if (kDebugMode) {
          print(locationType.children);
        }
        selectedLocationSubTypes.value = locationType.children!;
        if(selectedLocationSubTypes.isNotEmpty)
{        selectedsubType.value = selectedLocationSubTypes[0].type!;}
      }
    }
  }

  void changeSubType(String _subType) {
    for (var subType in selectedLocationSubTypes) {
      if (subType.type == _subType) {
        selectedsubType.value = subType.type!;
      }
    }
  }

  void selectEmirate(emirate) async {
    selectedEmirate.value = emirate['name'];
    selectedEmirateId.value = emirate['id'];
    //get the corresponding areas for this emirate
    await getEmriteAreas(emirate['id']);
  }

  void selectArea(Area area) {
    selectedArea.value = area.name!;
    selectedAreaId.value = area.id!;
  }

  void selectParkingArea(value) {
    selectedParkingArea.value = value;
  }

  addNewLocation() async {
    int locationTypeId = 0;
    if (checkValidation()) {
      loading.value = true;
      for (var locationType in locationTypes) {
        if (locationType.type == selectedLocationType.value) {
          selectedLocationType.value = locationType.type!;
          locationTypeId = locationType.id!;
        }
      }
            var type=Get.locale!.languageCode=='en'?selectedLocationType.value:LocationTypesISO[selectedLocationType.value];

      AddAddress? addNewAdressRequest = await AddressService.addNewAddress(
        buildingName: buildingNameController.text,
        apartmentNo: apartmentNumberController.text,
        parkingArea: selectedParkingArea.value,
        customField: aditionalInformationController.text,
         type: type,
        // type: Get.locale!.languageCode=='en'?selectedLocationType.value:LocationTypesISO[selectedLocationType.value],
        addressTypeId: locationTypeId,
        emirateId: selectedEmirateId.value,
        emirateCityId: selectedAreaId.value,
        address: streetController.text,
      );
      if (addNewAdressRequest!.message ==
              'Your address has been created successfully.' ||
          addNewAdressRequest!.message!.contains('بنجاح')) {
        errorMessage.value = "";
        toast(message: addNewAdressRequest.message.toString());
/*         await myLocationController.getLocationsListRequest(); */
        
        await locationController.getLoacationsRequest();
        Get.back();
        loading.value = false;
        return "added successfully";
      } else {
        if (addNewAdressRequest.message!.contains('required') ||
            addNewAdressRequest.message!.contains('invalid')) {
          Get.snackbar("Invalid Inputs", "Please Fill The Missing Fields",
              backgroundColor: ConstantColors.errorColor,
              colorText: Colors.white);
        }
        errorMessage.value = addNewAdressRequest.message!.split('.')[0];
        loading.value = false;
        return addNewAdressRequest.message;
      }
    }
  }

  deleteLocation(id) async {
    loading.value = true;
    String? deleteLocationRequest =
        await AddressService.deleteAddress(addressId: id);
    if (deleteLocationRequest! ==
            "Your address has been deleted successfully." ||
        deleteLocationRequest.contains('بنجاح')) {
      loading.value = false;
      errorMessage.value = "";
      toast(message: deleteLocationRequest.toString());
      /*  await myLocationController.getLocationsListRequest(); */
      await locationController.getLoacationsRequest();
      Get.back();
      return "deleted successfully";
    } else {
      errorMessage.value = deleteLocationRequest;
      loading.value = false;
      return deleteLocationRequest;
    }
  }

  updateLocation(addressId) async {
    if (checkValidation()) {
      loading.value = true;
      
      print("location ${LocationTypesISO[selectedLocationType.value]}");
      var type=Get.locale!.languageCode=='en'?selectedLocationType.value:LocationTypesISO[selectedLocationType.value];
      print("type $type");
      AddAddress? updateLocationRequesst = await AddressService.editAddress(
        addressId: addressId,
        buildingName: buildingNameController.text,
        apartmentNo: apartmentNumberController.text,
        parkingArea: selectedParkingArea.value,
        customField: aditionalInformationController.text,
        // type: LocationTypesISO[selectedLocationType.value],
        type: type,
        addressTypeId: selectedLocation.value.addressTypeId,
        emirateId: selectedEmirateId.value,
        emirateCityId: selectedAreaId.value,
        address: streetController.text,
      );
      if (updateLocationRequesst?.message ==
              "Your address has been updated successfully." ||
          updateLocationRequesst!.message!.contains('بنجاح')) {
        loading.value = false;
        errorMessage.value = "";
        toast(message: updateLocationRequesst!.message!);
        /*  await myLocationController.getLocationsListRequest(); */
        await locationController.getLoacationsRequest();
        Get.back();
        return "updated successfully";
      } else {
        errorMessage.value = updateLocationRequesst?.message ?? '';
        loading.value = false;
        return updateLocationRequesst;
      }
    }
  }
}
