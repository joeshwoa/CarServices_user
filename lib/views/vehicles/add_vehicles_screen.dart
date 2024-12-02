import 'dart:developer';
import 'dart:ffi';

import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/locations/addLocation-controller.dart';
import 'package:autoflex/controllers/menu/vehicles/add_vehicle_controller.dart';
import 'package:autoflex/controllers/menu/vehicles/edit_vehicle_controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/models/carModel.dart';
import 'package:autoflex/models/vehicle.dart';
import 'package:autoflex/models/vehiclesModel.dart';
import 'package:autoflex/shared/components/color_radio.dart';
import 'package:autoflex/shared/components/delete_pop-up.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/select_location_vehicle.dart';
import 'package:autoflex/shared/components/select_menu_item.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/views/welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/location_vehicle_radio.dart';
import '../../styles/colors.dart';
import '../../styles/icons_assets.dart';

class AddVehicleScreen extends StatelessWidget {
  /* final Datum? vehicle; */
  AddVehicleScreen({super.key});
  final AddVehicleController addVehicleController =
      Get.put(AddVehicleController());
  final carController = Get.find<CarController>();
  final editVehicleController = Get.put(EditVehicleController());
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {'type': 'add'};
    final type = args['type'];
    if (args['type'] == 'edit') {
      editVehicleController.editVehicleRequest(Get.arguments['id']);
    }
    return Obx(
      () {
        if (args['type'] == 'edit') {
          if (!editVehicleController.loading.value &&
              !editVehicleController.populated.value) {
            editVehicleController.populated.value = true;
            addVehicleController.selectType(
                editVehicleController.vehicle.value.data!.carType!.id!);
            addVehicleController
                .selectColor(editVehicleController.vehicle.value.data!.color.toString());
            addVehicleController.selectMake(
                editVehicleController.vehicle.value.data!.carBrand!.id);

            addVehicleController.selectModel(
                editVehicleController.vehicle.value.data!.carModel!.id);
            addVehicleController
                .selectYear(editVehicleController.vehicle.value.data!.year);
            addVehicleController.plateNumberController.text =
                editVehicleController.vehicle.value.data!.plateNumber!;
            addVehicleController.plateCodeController.text =
                editVehicleController.vehicle.value.data!.plateCode!;
            inspect(editVehicleController.vehicle.value.data?.emirateId);
            addVehicleController.selectEmriteCode(
                editVehicleController.vehicle.value.data?.emirateId.toString());
            if (editVehicleController.vehicle.value.data!.gearType == 'auto') {
              addVehicleController.selectGear(
                  '${editVehicleController.vehicle.value.data!.gearType}matic');
            } else {
              addVehicleController.selectGear(
                  editVehicleController.vehicle.value.data!.gearType);
            }
          }
        }
        return Stack(
          children: [
            Scaffold(
                backgroundColor: ConstantColors.backgroundColor,
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: ConstantColors.backgroundColor,
                  leading: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 16.0),
                    child: IconButton(
                      icon: Get.locale?.languageCode == 'en'
                          ? SvgPicture.asset(arrowBack)
                          : Transform.rotate(
                              angle: 3.14,
                              child: SvgPicture.asset(arrowBack),
                            ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 16.0),
                    child: Text(
                        args['type'] == 'add'
                            ? 'MY VEHICLES'.tr
                            : 'EDIT VEHICLE'.tr,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addVehicleController.types.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: addVehicleController.types
                                            .map((type) => Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Flexible(
                                                      child:
                                                          SelectLocationOrVehicle(
                                                        layoutType: 'column',
                                                        value: type.id,
                                                        groupValue:
                                                            addVehicleController
                                                                .selectedVehicleType
                                                                .value,
                                                        title: type.name
                                                            .toString(),
                                                        customIcon: type.name ==
                                                                    'Van' ||
                                                                type.name ==
                                                                    'SUV'
                                                            ? 'suv (7 seater)_small'
                                                            : type.name ==
                                                                    'Motorcycle'
                                                                ? 'motorcycle_small'
                                                                : 'sedan_small',
                                                        onChanged: (value) {
                                                          addVehicleController
                                                              .selectType(
                                                                  value!);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                ))
                                            .toList()),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 16,
                        ),
                        Form(
                            key: addVehicleController.addLocationFormKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: addVehicleController
                                                        .selectColorError
                                                        .value ==
                                                    ""
                                                ? ConstantColors.borderColor
                                                : ConstantColors.errorColor),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: ExpansionTile(
                                      onExpansionChanged: (bool expanded) {
                                        addVehicleController.changeExpanded(0);
                                      },
                                      controller: addVehicleController
                                          .expansionControllers[0],
                                      iconColor: ConstantColors.hintColor,
                                      collapsedIconColor:
                                          ConstantColors.hintColor,
                                      initiallyExpanded: false,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      title: args['type'] == 'add'
                                          ? Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Color'.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' ${addVehicleController.selectedcolor.value['name']?.toUpperCase() ?? ''}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Color'.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' ${editVehicleController.vehicle.value.data?.color?.toUpperCase()}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      children: [
                                        Wrap(
                                          children: addVehicleController.colors
                                              .map((color) {
                                            final colorName = color['name']
                                                as String; // Explicitly cast to String
                                            return ColorRadio(
                                              value: colorName,
                                              color: color['value'] as Gradient,
                                              name: colorName.capitalize,
                                              groupValue: addVehicleController
                                                  .selectedcolor['name'],
                                              onChanged: (value) {
                                                addVehicleController
                                                    .selectColor(value);
                                              },
                                            );
                                          }).toList(),
                                        )
                                      ],
                                    ),
                                  ),
                                  addVehicleController.selectColorError.value !=
                                          ''
                                      ? Column(
                                          children: [
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(addVehicleController
                                                .selectColorError.value),
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ConstantColors.borderColor),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: ExpansionTile(
                                      onExpansionChanged: (bool expanded) {
                                        addVehicleController.changeExpanded(1);
                                      },
                                      controller: addVehicleController
                                          .expansionControllers[1],
                                      iconColor: ConstantColors.hintColor,
                                      collapsedIconColor:
                                          ConstantColors.hintColor,
                                      initiallyExpanded: false,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      title: args['type'] == 'add'
                                          ? Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Make'.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: addVehicleController
                                                                .selectedMake
                                                                .value >
                                                            0
                                                        ? ' ${addVehicleController.brands[addVehicleController.selectedMake.value - 1].name?.toUpperCase() ?? ''}'
                                                        : '',
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '${'Make'.tr} ',
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: editVehicleController
                                                        .vehicle
                                                        .value
                                                        .data
                                                        ?.carBrand!
                                                        .name!
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                  bottom: 8),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText: 'Search',
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8),
                                                  hintStyle: const TextStyle(
                                                      color: ConstantColors
                                                          .hintColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  prefixIcon: const Icon(
                                                      Icons.search,
                                                      color: ConstantColors
                                                          .hintColor,
                                                      size: 18),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                ConstantColors
                                                                    .hintColor),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                ConstantColors
                                                                    .hintColor),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide: const BorderSide(
                                                        color: ConstantColors
                                                            .secondaryColor),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  addVehicleController
                                                      .brandSearch(value);
                                                },
                                              ),
                                            ),
                                            Column(
                                              children: addVehicleController
                                                  .brands
                                                  .map(
                                                    (brand) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              left: 16,
                                                              right: 16),
                                                      child: SelectMenuItem(
                                                        value: brand.id,
                                                        title: brand.name
                                                            .toString()
                                                            .toUpperCase(),
                                                        groupValue:
                                                            addVehicleController
                                                                .selectedMake
                                                                .value,
                                                        onChanged: (value) {
                                                          addVehicleController
                                                              .selectMake(
                                                                  value);
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ConstantColors.borderColor),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: ExpansionTile(
                                      onExpansionChanged: (bool expanded) {
                                        addVehicleController.changeExpanded(2);
                                      },
                                      controller: addVehicleController
                                          .expansionControllers[2],
                                      iconColor: ConstantColors.hintColor,
                                      collapsedIconColor:
                                          ConstantColors.hintColor,
                                      initiallyExpanded: false,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      title: args['type'] == 'add'
                                          ? Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Model '.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: addVehicleController
                                                                .selectedModel
                                                                .value >
                                                            0
                                                        ? ' ${addVehicleController.models.firstWhere((model) => model.id == addVehicleController.selectedModel.value).name.toUpperCase() ?? ''}'
                                                        : '',
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Model '.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: editVehicleController
                                                        .vehicle
                                                        .value
                                                        .data
                                                        ?.carModel!
                                                        .name!
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                  bottom: 8),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText: 'Search'.tr,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8),
                                                  hintStyle: const TextStyle(
                                                      color: ConstantColors
                                                          .hintColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  prefixIcon: const Icon(
                                                      Icons.search,
                                                      color: ConstantColors
                                                          .hintColor,
                                                      size: 18),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                ConstantColors
                                                                    .hintColor),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                ConstantColors
                                                                    .hintColor),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide: const BorderSide(
                                                        color: ConstantColors
                                                            .secondaryColor),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  addVehicleController
                                                      .modelSearch(value);
                                                },
                                              ),
                                            ),
                                            Column(
                                              children: addVehicleController
                                                  .models
                                                  .map(
                                                    (model) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0,
                                                              left: 16,
                                                              right: 16),
                                                      child: SelectMenuItem(
                                                        value: model.id,
                                                        title: (model.name
                                                                as String)
                                                            .toUpperCase(),
                                                        groupValue:
                                                            addVehicleController
                                                                .selectedModel
                                                                .value,
                                                        onChanged: (value) {
                                                          addVehicleController
                                                              .selectModel(
                                                                  value);
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ConstantColors.borderColor),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: ExpansionTile(
                                      onExpansionChanged: (bool expanded) {
                                        addVehicleController.changeExpanded(3);
                                      },
                                      controller: addVehicleController
                                          .expansionControllers[3],
                                      iconColor: ConstantColors.hintColor,
                                      collapsedIconColor:
                                          ConstantColors.hintColor,
                                      initiallyExpanded: false,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      title: args['type'] == 'add'
                                          ? Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Year '.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: addVehicleController
                                                                .selectedYear
                                                                .value
                                                                .toString() ==
                                                            '0'
                                                        ? ''
                                                        : addVehicleController
                                                            .selectedYear.value
                                                            .toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Year '.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: editVehicleController
                                                        .vehicle
                                                        .value
                                                        .data
                                                        ?.year
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    bottom: 8),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    hintText: 'Search'.tr,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8),
                                                    hintStyle: const TextStyle(
                                                        color: ConstantColors
                                                            .hintColor,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    prefixIcon: const Icon(
                                                        Icons.search,
                                                        color: ConstantColors
                                                            .hintColor,
                                                        size: 18),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  ConstantColors
                                                                      .hintColor),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  ConstantColors
                                                                      .hintColor),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide: const BorderSide(
                                                          color: ConstantColors
                                                              .secondaryColor),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    // Handle search input change
                                                  },
                                                ),
                                              ),
                                              Wrap(
                                                children: addVehicleController
                                                    .years
                                                    .map(
                                                      (year) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0,
                                                                left: 8,
                                                                right: 8),
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                          child: SelectMenuItem(
                                                            layout: 'row',
                                                            value: year,
                                                            title: (year
                                                                    .toString())
                                                                .toUpperCase(),
                                                            groupValue:
                                                                addVehicleController
                                                                    .selectedYear
                                                                    .value,
                                                            onChanged: (value) {
                                                              addVehicleController
                                                                  .selectYear(
                                                                      value);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ConstantColors.borderColor),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: ExpansionTile(
                                      onExpansionChanged: (bool expanded) {
                                        addVehicleController.changeExpanded(4);
                                      },
                                      controller: addVehicleController
                                          .expansionControllers[4],
                                      iconColor: ConstantColors.hintColor,
                                      collapsedIconColor:
                                          ConstantColors.hintColor,
                                      initiallyExpanded: false,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      title: args['type'] == 'add'
                                          ? Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'License Plate  '.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: addVehicleController
                                                                .plateCodeController
                                                                .text ==
                                                            ''
                                                        ? ""
                                                        : "${addVehicleController.plateCodeController.text} - ${addVehicleController.plateNumberController.text}",
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'License Plate  '.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "${editVehicleController.vehicle.value.data?.plateCode} - ${editVehicleController.vehicle.value.data?.plateNumber}",
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.30,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 1.5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ConstantColors
                                                            .borderColor),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                3))), // Specify a width for the DropdownButton
                                                child: DropdownButton(
                                                  isExpanded: true,
                                                  hint: addVehicleController
                                                              .selectedCode
                                                              .value['name'] !=
                                                          null
                                                      ? Text(
                                                          addVehicleController
                                                              .selectedCode
                                                              .value['name']
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        )
                                                      : Text(
                                                          'Select Emirate'.tr,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelMedium!
                                                              .copyWith(
                                                                  color: ConstantColors
                                                                      .bodyColor)),
                                                  items: addVehicleController
                                                      .emriteCodes
                                                      .map((code) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value:
                                                          code['id'].toString(),
                                                      child: Text(code['name']
                                                          .toString()),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    addVehicleController
                                                        .selectEmriteCode(
                                                            value);
                                                  },
                                                  icon: SvgPicture.asset(
                                                      arrowDown),
                                                  underline: const SizedBox(),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0,
                                                          left: 8.0),
                                                  child: textField(
                                                      context: context,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      controller:
                                                          addVehicleController
                                                              .plateCodeController,
                                                      hint: 'Plate Code'.tr,
                                                      hintStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge,
                                                      validate: (value) {
                                                        return Validations
                                                            .validateField(
                                                                value, context);
                                                      },
                                                      isPassword: false,
                                                      disabled: false,
                                                      change: (value) {}),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: textField(
                                                      context: context,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          addVehicleController
                                                              .plateNumberController,
                                                      hint: 'Plate Number'.tr,
                                                      hintStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge,
                                                      validate: (value) {
                                                        return Validations
                                                            .validateField(
                                                                value, context);
                                                      },
                                                      isPassword: false,
                                                      disabled: false,
                                                      change: (value) {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ConstantColors.borderColor),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: ExpansionTile(
                                      onExpansionChanged: (bool expanded) {
                                        addVehicleController.changeExpanded(5);
                                      },
                                      controller: addVehicleController
                                          .expansionControllers[5],
                                      iconColor: ConstantColors.hintColor,
                                      collapsedIconColor:
                                          ConstantColors.hintColor,
                                      initiallyExpanded: false,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      title: args['type'] == 'add'
                                          ? Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Gear Type '.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: addVehicleController
                                                            .selectedGear
                                                            .toUpperCase() ??
                                                        '',
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Gear Type '.tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFF45464C),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: editVehicleController
                                                        .vehicle
                                                        .value
                                                        .data
                                                        ?.gearType!
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      color: Color(0xFF00A9DF),
                                                      fontSize: 15,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      letterSpacing: -0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: addVehicleController.gears
                                              .map((gear) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                  left: 8,
                                                  right: 8),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: SelectMenuItem(
                                                  layout: 'row',
                                                  value: gear,
                                                  title: gear.toUpperCase(),
                                                  groupValue:
                                                      addVehicleController
                                                          .selectedGear.value,
                                                  onChanged: (value) {
                                                    addVehicleController
                                                        .selectGear(value);
                                                  },
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  addVehicleController.errorMessage.value != ""
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              textScaleFactor: 1,
                                              addVehicleController
                                                  .errorMessage.value,
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                color:
                                                    ConstantColors.errorColor,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  args['type'] == 'add'
                                      ? FormSubmitButton(
                                          disabled: false,
                                          onPressed: () {
                                            addVehicleController
                                                .addNewVehicleRequest();
                                          },
                                          label: 'Save'.tr,
                                          context: context)
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Material(
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    border: Border.all(
                                                      color: ConstantColors
                                                          .primaryColor, // Set the border color
                                                      width:
                                                          1.0, // Set the border width
                                                    ),
                                                  ),
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      addVehicleController
                                                          .updateVehicleRequest();
                                                    },
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 15.0),
                                                        child: Text(
                                                          'Update'.tr,
                                                          style: TextStyle(
                                                            color: ConstantColors
                                                                .primaryColor,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily: localization ==
                                                                    "en"
                                                                ? GoogleFonts
                                                                        .roboto()
                                                                    .fontFamily
                                                                : 'DubaiFont',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: Material(
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0)),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    Get.dialog(
                                                      DeletePopUp(
                                                        deletable: 'vehicle'.tr,
                                                      ),
                                                    ).then((result) {
                                                      result ??= false;

                                                      if (result == true) {
                                                        addVehicleController
                                                            .deleteVehicleRequest();
                                                      }
                                                    });
                                                  },
                                                  color:
                                                      ConstantColors.errorColor,
                                                  child: Center(
                                                      child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 15.0),
                                                    child: Text(
                                                      'Delete'.tr,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            localization == "en"
                                                                ? GoogleFonts
                                                                        .roboto()
                                                                    .fontFamily
                                                                : 'DubaiFont',
                                                      ),
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                ]))
                      ],
                    ),
                  ),
                )),
            editVehicleController.loading.value ||
                    addVehicleController.loading.value
                ? const LoadingWidget()
                : const Row()
          ],
        );
      },
    );
  }
}
