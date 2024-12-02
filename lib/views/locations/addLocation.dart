import 'dart:developer';

import 'package:autoflex/controllers/locations/addLocation-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/select_location_vehicle.dart';
import 'package:autoflex/shared/components/select_menu_item.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/views/locations/addEmirate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/location_vehicle_radio.dart';
import '../../styles/colors.dart';
import '../../styles/icons_assets.dart';

class AddLocationScreen extends StatelessWidget {
  AddLocationScreen({super.key});
  final AddLocationController controller = Get.put(AddLocationController());
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {'type': 'add'};
    final type = args['type'];
 
    return Obx(
      () => Stack(children: [
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
                  Get.arguments!=null
                    ?Get.arguments['type'] == 'add'
                        ? 'ADD LOCATION'.tr
                        : 'EDIT LOCATION'.tr:'',
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
                    controller.locationTypes.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: controller.locationTypes
                                        .map((locationType) => Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child:
                                                      SelectLocationOrVehicle(
                                                    layoutType: 'row',
                                                    value: locationType.type,
                                                    groupValue: controller
                                                        .selectedLocationType
                                                        .value,
                                                    title: locationType.type
                                                        .toString(),
                                                    customIcon: locationType
                                                                .type ==
                                                            'Home'.tr
                                                        ? 'home_small'
                                                        : locationType.type ==
                                                                'Work'.tr
                                                            ? 'work_small'
                                                            : 'address',
                                                    onChanged: (value) {
                                                      controller
                                                          .changeLocationType(
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
                              const SizedBox(
                                height: 16,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: controller
                                        .selectedLocationSubTypes
                                        .map((subType) => Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child:
                                                      //not valid in arabic(NOT FIXED YET)
                                                      SelectLocationOrVehicle(
                                                    layoutType: 'row',
                                                    value: subType.type,
                                                    groupValue: controller
                                                        .selectedsubType.value,
                                                    title:
                                                        subType.type.toString(),
                                                    customIcon: subType.type ==
                                                            'Villa'.tr
                                                        ? 'villa'
                                                        : subType.type ==
                                                                'Apartment'
                                                            ? 'apartment'
                                                            : 'work_small',
                                                    onChanged: (value) {
                                                      controller.changeSubType(
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
                        key: controller.addLocationFormKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: ConstantColors.borderColor),
                                ),
                                child: ExpansionTile(
                                  onExpansionChanged: (bool expanded) {
                                    controller.changeExpanded(0);
                                  },
                                  controller:
                                      controller.expansionControllers[0],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  collapsedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0)),
                                  iconColor: ConstantColors.hintColor,
                                  collapsedIconColor: ConstantColors.hintColor,
                                  initiallyExpanded: false,
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  title: Text(
                                    controller.selectedEmirate.value != ''
                                        ? controller.selectedEmirate.value
                                        : 'Select Emirate'.tr,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  children: [
                                    Column(
                                      children: [
                                        Column(
                                          children: controller.emirates
                                              .map(
                                                (emirate) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0,
                                                          left: 16,
                                                          right: 16),
                                                  child: SelectMenuItem(
                                                    value: int.parse(
                                                        emirate["id"]
                                                            .toString()),
                                                    title: emirate["name"]
                                                        ?.toString()
                                                        .toUpperCase(),
                                                    groupValue: controller
                                                        .selectedEmirateId
                                                        .value,
                                                    onChanged: (value) {
                                                      controller.selectEmirate(
                                                          emirate);
                                                    },
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     Get.to(() => AddEmirateScreen());
                                        //   },
                                        //   child: FractionallySizedBox(
                                        //     widthFactor: 1,
                                        //     child: Container(
                                        //       margin: EdgeInsets.only(
                                        //           left: 16, right: 16, bottom: 16),
                                        //       padding: const EdgeInsets.all(12),
                                        //       decoration: BoxDecoration(
                                        //           color: ConstantColors
                                        //               .backgroundColor,
                                        //           border: Border.all(
                                        //               color: ConstantColors
                                        //                   .borderColor),
                                        //           borderRadius:
                                        //               const BorderRadius.all(
                                        //                   Radius.circular(8))),
                                        //       child: Text(
                                        //         'Didn’t Find Emirate? (Request to Add)',
                                        //         style: TextStyle(
                                        //             fontSize: 13,
                                        //             fontWeight: FontWeight.w600,
                                        //             color:
                                        //                 ConstantColors.errorColor,
                                        //             fontFamily: localization == "en"
                                        //                 ? GoogleFonts.roboto()
                                        //                     .fontFamily
                                        //                 : 'DubaiFont'),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
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
                                    controller.changeExpanded(1);
                                  },
                                  controller:
                                      controller.expansionControllers[1],
                                  iconColor: ConstantColors.hintColor,
                                  collapsedIconColor: ConstantColors.hintColor,
                                  initiallyExpanded: false,
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  title: Text(
                                    controller.selectedArea.value != ''
                                        ? controller.selectedArea.value
                                        : 'Select Area'.tr,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              hintStyle: const TextStyle(
                                                  color:
                                                      ConstantColors.hintColor,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              prefixIcon: const Icon(
                                                  Icons.search,
                                                  color:
                                                      ConstantColors.hintColor,
                                                  size: 18),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: ConstantColors
                                                        .hintColor),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: ConstantColors
                                                        .hintColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: ConstantColors
                                                        .secondaryColor),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              controller.areaSearch(value);
                                            },
                                          ),
                                        ),
                                        controller.loading.value
                                            ? const SizedBox()
                                            : Column(
                                                children: controller.areas
                                                    .map(
                                                      (area) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0,
                                                                left: 16,
                                                                right: 16),
                                                        child: SelectMenuItem(
                                                          value: area.id,
                                                          title: area.name
                                                              .toString()
                                                              .toUpperCase(),
                                                          groupValue: controller
                                                              .selectedAreaId
                                                              .value,
                                                          onChanged: (value) {
                                                            controller
                                                                .selectArea(
                                                                    area);
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
                              //not valid in arabic(NOT FIXED YET)
                              controller.selectedsubType.value == 'Villa'.tr
                                  ? Column(
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: textField(
                                              context: context,
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: controller
                                                  .villaNumberController,
                                              hint: 'Villa Number'.tr,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                              validate: (value) {},
                                              isPassword: false,
                                              change: (value) {},
                                              disabled: false),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    )
                                  //not valid in arabic(NOT FIXED YET)
                                  : controller.selectedsubType.value ==
                                          'Apartment'.tr
                                      ? Column(
                                          children: [
                                            textField(
                                                context: context,
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: controller
                                                    .buildingNameController,
                                                hint: 'Building Name'.tr,
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                                validate: (value) {},
                                                isPassword: false,
                                                change: (value) {},
                                                disabled: false),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: textField(
                                                  context: context,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: controller
                                                      .apartmentNumberController,
                                                  hint: 'Apartment No.'.tr,
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                  validate: (value) {},
                                                  isPassword: false,
                                                  change: (value) {},
                                                  disabled: false),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            textField(
                                                context: context,
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: controller
                                                    .buildingNameController,
                                                hint: 'Building Name'.tr,
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                                validate: (value) {},
                                                isPassword: false,
                                                change: (value) {},
                                                disabled: false),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                              textField(
                                  context: context,
                                  keyboardType: TextInputType.streetAddress,
                                  controller: controller.streetController,
                                  hint: 'Street No./Name'.tr,
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                  validate: (value) {},
                                  isPassword: false,
                                  change: (value) {},
                                  disabled: false),
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
                                    controller.changeExpanded(2);
                                  },
                                  controller:
                                      controller.expansionControllers[2],
                                  iconColor: ConstantColors.hintColor,
                                  collapsedIconColor: ConstantColors.hintColor,
                                  initiallyExpanded: false,
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  title: Text(
                                    controller.selectedParkingArea.value != ''
                                        ? controller.selectedParkingArea.value
                                        : 'Parking Area'.tr,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  children: [
                                    Column(
                                      children: controller.parkingAreas
                                          .map(
                                            (area) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                  left: 16,
                                                  right: 16),
                                              child: SelectMenuItem(
                                                value: area,
                                                title: area.toUpperCase(),
                                                groupValue: controller
                                                    .selectedParkingArea.value,
                                                onChanged: (value) {
                                                  controller.selectParkingArea(
                                                      value!);
                                                },
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              textField(
                                  context: context,
                                  keyboardType: TextInputType.text,
                                  controller:
                                      controller.aditionalInformationController,
                                  hint:
                                      'Additional Information/Instructions'.tr,
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                  validate: (value) {},
                                  isPassword: false,
                                  change: (value) {},
                                  disabled: false),
                              controller.errorMessage.value != ""
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          textScaleFactor: 1,
                                          controller.errorMessage.value,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: ConstantColors.errorColor,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),

                              const SizedBox(
                                height: 16,
                              ),
                        
                             type == 'add'
                                  ? FormSubmitButton(
                                      disabled: false,
                                      onPressed: () {
                                        controller.addNewLocation();
                                      },
                                      label: 'Save'.tr,
                                      context: context)
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ConstantColors
                                                      .primaryColor),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Material(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            child: MaterialButton(
                                              onPressed: () => {
                                                controller.updateLocation(
                                                    Get.arguments['LocationId'])
                                              },
                                              color: ConstantColors
                                                  .backgroundColor,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15.0),
                                                child: Text(
                                                  'Update'.tr,
                                                  style: TextStyle(
                                                    color: ConstantColors
                                                        .primaryColor,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: localization ==
                                                            "en"
                                                        ? GoogleFonts.roboto()
                                                            .fontFamily
                                                        : 'DubaiFont',
                                                  ),
                                                ),
                                              )),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Material(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            child: MaterialButton(
                                              onPressed: () => {
                                                controller.deleteLocation(
                                                    Get.arguments['LocationId'])
                                              },
                                              color: ConstantColors.errorColor,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15.0),
                                                child: Text(
                                                  'Delete'.tr,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: localization ==
                                                            "en"
                                                        ? GoogleFonts.roboto()
                                                            .fontFamily
                                                        : 'DubaiFont',
                                                  ),
                                                ),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              const SizedBox(
                                height: 16,
                              )
                            ]))
                  ],
                ),
              ),
            )),
        controller.loading.value ? const LoadingWidget() : const Row()
      ]),
    );
  }
}
