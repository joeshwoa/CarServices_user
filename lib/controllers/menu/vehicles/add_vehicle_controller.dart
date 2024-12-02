import 'dart:developer';

import 'package:autoflex/models/carModel.dart';
import 'package:autoflex/models/vehicle.dart' as vehicle;
import 'package:autoflex/models/vehicleTypeBrandModel.dart';
import 'package:autoflex/models/vehiclesModel.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/views/vehicles/add_vehicles_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../services/Home/vehiclesServices.dart';
import '../../home/carController.dart';

class AddVehicleController extends GetxController {
  final addLocationFormKey = GlobalKey<FormState>();
  final carController = Get.find<CarController>();
  var expansionControllers = [
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
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

  var loading = false.obs;
  //vehicle type
  var types = <Data>[].obs;
  var typeNames = ['sedan', 'suv5', 'suv7', 'motorcycle'];
  var selectedVehicleType = 1.obs;

  //vehicle color
  var colors = [
    {
      'name': 'white'.tr,
      'value': const LinearGradient(
        begin: Alignment(0.44, -0.90),
        end: Alignment(-0.44, 0.9),
        colors: [Colors.white, Color(0xFFEEEEEE)],
      )
    },
    {
      'name': 'black'.tr,
      'value': const LinearGradient(
        begin: Alignment(0.44, -0.90),
        end: Alignment(-0.44, 0.9),
        colors: [Color(0xFF555555), Colors.black],
      )
    },
    {
      'name': 'silver'.tr,
      'value': const LinearGradient(
        begin: Alignment(0.44, -0.90),
        end: Alignment(-0.44, 0.9),
        colors: [Color(0xFFDDDDDD), Color(0xFF666677)],
      )
    },
    {
      'name': 'red'.tr,
      'value': const LinearGradient(
        begin: Alignment(0.44, -0.90),
        end: Alignment(-0.44, 0.9),
        colors: [Color(0xFFFF0000), Color(0xFFAA0000)],
      )
    },
    {
      'name': 'blue'.tr,
      'value': const LinearGradient(
        begin: Alignment(0.44, -0.90),
        end: Alignment(-0.44, 0.9),
        colors: [Color(0xFF0000FF), Color(0xFF0000CC)],
      )
    },
    {
      'name': 'brown'.tr,
      'value': const LinearGradient(
        begin: Alignment(0.44, -0.90),
        end: Alignment(-0.44, 0.9),
        colors: [Color(0xFFC9AD49), Color(0xFF5C3817)],
      )
    },
    {
      'name': 'yellow'.tr,
      'value': const LinearGradient(
        begin: Alignment(0.44, -0.90),
        end: Alignment(-0.44, 0.9),
        colors: [Color(0xFFFFEE00), Color(0xFFFFCC00)],
      )
    },
    {
      'name': 'green'.tr,
      'value': const LinearGradient(
        begin: Alignment(0.44, -0.90),
        end: Alignment(-0.44, 0.9),
        colors: [Color(0xFF00FF00), Color(0xFF009900)],
      )
    },
    {
      'name': 'grey'.tr,
      'value': const LinearGradient(
        begin: Alignment(0.44, -0.90),
        end: Alignment(-0.44, 0.9),
        colors: [Colors.white, Color(0xFFEEEEEE)],
      )
    },
    {
      'name': 'other'.tr,
      'value': const SweepGradient(
        center: Alignment(-0.17, 0.71),
        startAngle: -0.44,
        endAngle: -0.90,
        colors: [
          Color(0xFFBFD877),
          Color(0xFFC98080),
          Color(0xFF777AB2),
          Color(0xFF6953C5),
          Color(0xFFB6C0BD)
        ],
      )
    },
  ].obs;
  var selectedcolor = {}.obs;

  //vehicle brand
  var makes = ['BMW', 'Mercedes-Benz', 'Toyota', 'KIA'].obs;
  var selectedMake = (-1).obs;

  //vehicle model
  var brands = <Data>[].obs;
  var originalBrands = <Data>[].obs;
  var models = [].obs;
  var originalModels = [].obs;
  var selectedModel = 0.obs;

  //manufacture year
  var years = [].obs;
  var selectedYear = 0.obs;

  //plate
  var emriteCodes = [
    {'id': 1, "name": 'Abu Dhabi'.tr},
    {'id': 2, "name": 'Dubai'.tr},
    {'id': 3, "name": 'Sharjah'.tr},
    {'id': 4, "name": 'Ajman'.tr},
    {'id': 5, "name": 'Umm Al Quwain'.tr},
    {'id': 6, "name": 'Ras Al Khaimah'.tr},
    {'id': 7, "name": 'Fujairah'.tr}
  ].obs;
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController plateCodeController = TextEditingController();
  var selectedCode = {}.obs;
  var plateNumber = ''.obs;
  var errorMessage = ''.obs;
// var
  var selectBrandError = ''.obs;
  var selectModelError = ''.obs;
  var selectYearError = ''.obs;
  var selectColorError = ''.obs;
  var selectGearError = ''.obs;
  var selectCodeError = ''.obs;
  //gear type
  var gears = ['automatic'.tr, 'manual'.tr].obs;
  var selectedGear = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    var generated = List.generate(25, (index) => (DateTime.now().year - index));
    years.value = generated;
    await getVehicleTypesRequest();
    await getVehicleBrandsRequest();
    selectedVehicleType.value = types[0].id!;
    // selectedMake.value=brands[0].id.toString();
    // selectedModel.value=models[0].id.toString();
  }

  Future<VehicleTypeBrandModel?> getVehicleTypesRequest() async {
    try {
      loading.value = true;
      VehicleTypeBrandModel? getVehicleTypesRequest =
          await VehiclesService.getTypes();
      types.value = getVehicleTypesRequest!.data!;
      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<VehicleTypeBrandModel?> getVehicleBrandsRequest() async {
    try {
      loading.value = true;
      VehicleTypeBrandModel? getVehicleBrandsRequest =
          await VehiclesService.getBrands();
      brands.value = getVehicleBrandsRequest!.data!;
      originalBrands.value = getVehicleBrandsRequest!.data!;
      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<VehicleTypeBrandModel?> getVehicleModelsRequest(brandId) async {
    try {
      loading.value = true;
      VehicleTypeBrandModel? getVehicleModelsRequest =
          await VehiclesService.getModels(brandId);
      models.value = getVehicleModelsRequest!.data!;
      originalModels.value = getVehicleModelsRequest!.data!;
      inspect(models.value);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  brandSearch(keyword) {
    if (keyword.isEmpty) {
      brands.value = List.from(originalBrands.value);
    } else {
      brands.value = originalBrands
          .where((brand) => brand.name!.contains(keyword))
          .toList();
    }
  }

  modelSearch(keyword) {
    if (keyword.isEmpty) {
      models.value = List.from(originalModels.value);
    } else {
      models.value = originalModels
          .where((model) => model.name!.contains(keyword))
          .toList();
    }
  }

  checkValidation() {
//     if(selectedcolor.value=={}){
// selectColorError.value='you must select color';
//     }
    final isValid = addLocationFormKey.currentState!.validate();
    if (!isValid) {
      return false;

      // } else if(selectBrandError.value!=''&&selectModelError.value!=''&&selectGearError.value!=''&&
      // selectCodeError.value!=''&&selectYearError.value!=''&&selectColorError.value!='') {

      //   return false;
    } else {
      return true;
    }
  }

  void selectType(int type) {
    selectedVehicleType.value = type;
  }

  void selectColor(String colorName) {
    for (var item in colors) {
      if (item['name'] == colorName) {
        selectedcolor.value = item;
        return;
      }
    }

    selectedcolor.value = {};
  }

  void selectMake(make) async {
    inspect(make);
    selectedMake.value = make;
    selectedModel.value = -1;
    await getVehicleModelsRequest(selectedMake);
    // models.addAll(getModels(make));
  }

  // List<String> getModels(String make) {
  //   models.clear();
  //   for (var brand in brands) {
  //     if (brand['make'] == make) {
  //       return brand['models'] as List<String>;
  //     }
  //   }
  //   return [];
  // }

  void selectModel(model) {
    inspect(model);
    selectedModel.value = model;
  }

  void selectYear(year) {
    selectedYear.value = year;
  }

  void selectGear(gear) {
    selectedGear.value = gear;
  }

  void selectEmriteCode(code) {
    for (var i = 0; i < emriteCodes.length; i++) {
      if (emriteCodes[i]['id'] == int.parse(code)) {
        selectedCode.value = emriteCodes[i];
        return;
      }
    }
  }

  String getPlate() {
    if (plateCodeController.text != '' || plateNumberController.text != '') {
      return '${selectedCode.value}-${plateCodeController.text}-${plateNumberController.text}';
    }
    return '';
  }

  addNewVehicleRequest() async {
    if (checkValidation()) {
      try {
        loading.value = true;
        print(selectedcolor.value['name']);
        vehicle.Vehicle? addNewVehicleRequest =
            await VehiclesService.addNewVehicle(
                carTypeId: selectedVehicleType.value,
                carBrandId: selectedMake.value,
                carModelId: selectedModel.value,
                color: selectedcolor.value['name'],
                year: selectedYear.value,
                gearType: selectedGear.value,
                plateCode: plateCodeController.text,
                plateNumber: plateNumberController.text,
                emirateId: selectedCode.value['id']);
        // return '';
        if (addNewVehicleRequest!.message ==
                'Vehicle have been successfully added.' ||
            addNewVehicleRequest!.message!.contains('بنجاح')) {
          
          errorMessage.value = "";
          toast(message: addNewVehicleRequest.message.toString());
         
          await carController.getVehiclesRequest();
          Get.back();
           loading.value = false;
          return "registered successfully";
        } else {
          if (addNewVehicleRequest.message!.contains('required') ||
              addNewVehicleRequest.message!.contains('invalid')) {
            Get.snackbar("Invalid Inputs", "Please Fill The Missing Fields",
                backgroundColor: ConstantColors.errorColor,
                colorText: Colors.white);
          } else if (addNewVehicleRequest.message!.contains('integer')) {
            Get.snackbar("Invalid Inputs", addNewVehicleRequest.message!,
                backgroundColor: ConstantColors.errorColor,
                colorText: Colors.white);
          }
          errorMessage.value = addNewVehicleRequest.message!.split('.')[0];
          loading.value = false;
          return addNewVehicleRequest.message;
        }
        // }
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }

  updateVehicleRequest() async {
    if (checkValidation()) {
      try {
        loading.value = true;
          print(selectedcolor.value['name']);
        vehicle.Vehicle? updateVehicleRequest =
            await VehiclesService.updateVehicle(
                carId: carController.car.value.id!,
                carTypeId: selectedVehicleType.value,
                carBrandId: selectedMake.value,
                carModelId: selectedModel.value,
                color: selectedcolor.value['name'],
                year: selectedYear.value,
                gearType: selectedGear.value,
                plateCode: plateCodeController.text,
                plateNumber: plateNumberController.text,
                emirateId: selectedCode.value['id']);
        if (updateVehicleRequest!.message == 'Vehicle updated successfully.' ||
            updateVehicleRequest!.message!.contains('بنجاح')) {
          loading.value = false;
          errorMessage.value = "";
          toast(message: updateVehicleRequest.message.toString());
          carController.getVehiclesRequest();
          Get.back();
          return "Updated successfully";
        } else {
          errorMessage.value = updateVehicleRequest.message!;
          loading.value = false;
          return updateVehicleRequest.message;
        }
        // }
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }

  deleteVehicleRequest() async {
    String? deleteVehicleRequest =
        await VehiclesService.deleteVehicle(carController.car.value.id!);
    if (deleteVehicleRequest == "Vehicle successfully deleted." ||
        deleteVehicleRequest!.contains('بنجاح')) {
      loading.value = false;
      errorMessage.value = "";
      toast(message: deleteVehicleRequest!);
      carController.getVehiclesRequest();
      Get.back();
      return "deleted successfully";
    }
  }

  Datum? createNewVehicle() {
    if (checkValidation()) {
      return Datum(
        name: '${selectedMake.value} ${selectedModel.value}',
        plateNumber: getPlate(),
        // type: typeNames[types.indexOf(selectedVehicleType.value)],
        color: selectedcolor['name'],
        year: selectedYear.value as int,
        gearType: selectedGear.value,
      );
    }
    return null;
  }

  // editVehicle(Datum car) {
  //   // selectedVehicleType.value = types[typeNames.indexOf(car.carType!.name!)];
  //   selectColor(car.color!);
  //   // selectedCode.value = car.plateNumber!.split('-')[0];
  //   plateCodeController.text = car.plateNumber!.split('-')[1];
  //   plateNumberController.text = car.plateNumber!.split('-')[2];
  //   selectedMake.value = car.carType!.name!.split(' ')[0];
  //   selectedModel.value = car.carType!.name!.split(' ')[1];
  //   selectedYear.value = car.year!.toString();
  //   selectedGear.value = car.gearType!;
  //   Get.to(() => AddVehicleScreen(car: car), arguments: {'type': 'edit'});
  // }

  @override
  void onClose() {
    super.onClose();
    selectedVehicleType.value = 0;
    selectedcolor.clear();
    selectedMake.value = 0;
    selectedModel.value = 0;
    selectedYear.value = 0;
    selectedGear.value = '';
  }
}
