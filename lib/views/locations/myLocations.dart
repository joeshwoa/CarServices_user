import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/shared/components/location_vehicle_radio.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/views/locations/addLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/locations/myLocations-controller.dart';
import '../../shared/components/custom_radio.dart';
import '../../styles/icons_assets.dart';

class MyLocationsScreen extends StatelessWidget {
  MyLocationsScreen({super.key});
  /* final MyLocationsController controller = Get.put(MyLocationsController()); */
  final controller = Get.find<LocationController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
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
            child: Text('MY LOCATIONS'.tr,
                style: Theme.of(context).textTheme.titleLarge),
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(addCircle),
              onPressed: () {
                Get.to(() => AddLocationScreen(), arguments: {'type': 'add'});
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
            child: controller.locations.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: controller.locations
                              .map((location) => LocationVehicleRadio(
                                    type: 'location',
                                    screenName: 'myLocations',
                                    value: location.id,
                                    title: Text(location.type.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge),
                                    subtitle: Container(
                                      width: 150,
                                      child: Text(
                                        '${location.apartmentNo!} ${location.buildingName!}, ${'Street'.tr} ${location.address}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                        maxLines: 3,
                                      ),
                                    ),
                                    groupValue: controller.location.value!.id,
                                    onChanged: (value) {
                                      controller.changelocation(value!);
                                    },
                                    //not valid in arabic(NOT FIXED YET)
                                    customIcon: location.type == 'Home'.tr
                                        ? 'home'
                                        : 'work',
                                    editIcon: 'border_color',
                                    edit: () {
                                      controller.editLocation();
                                    },
                                  ))
                              .toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              SvgPicture.asset(addLocation),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: Text(
                                'Add Another Address'.tr,
                                style: Theme.of(context).textTheme.displayLarge,
                              )),
                              IconButton(
                                icon: Get.locale?.languageCode == 'en'
                                    ? SvgPicture.asset(arrow_right)
                                    : Transform.rotate(
                                        angle: 3.14,
                                        child: SvgPicture.asset(arrow_right),
                                      ),
                                onPressed: () {
                                  Get.to(() => AddLocationScreen(),
                                      arguments: {'type': "add"});
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsetsDirectional.only(start: 12),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0,
                                      color: ConstantColors.borderColor))),
                          child: Row(
                            children: [
                              SvgPicture.asset(homeSmall),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                'Add Home Address'.tr,
                                style: Theme.of(context).textTheme.displayLarge,
                              )),
                              IconButton(
                                icon: Get.locale?.languageCode == 'en'
                                    ? SvgPicture.asset(arrow_right)
                                    : Transform.rotate(
                                        angle: 3.14,
                                        child: SvgPicture.asset(arrow_right),
                                      ),
                                onPressed: () {
                                  Get.to(() => AddLocationScreen(),
                                      arguments: {'type': "add"});
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.only(start: 12),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0,
                                      color: ConstantColors.borderColor))),
                          child: Row(
                            children: [
                              SvgPicture.asset(workSmall),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                'Add Work Address'.tr,
                                style: Theme.of(context).textTheme.displayLarge,
                              )),
                              IconButton(
                                icon: Get.locale?.languageCode == 'en'
                                    ? SvgPicture.asset(arrow_right)
                                    : Transform.rotate(
                                        angle: 3.14,
                                        child: SvgPicture.asset(arrow_right),
                                      ),
                                onPressed: () {
                                  Get.to(() => AddLocationScreen(),
                                      arguments: {'type': "add"});
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.only(start: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset(address),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                'Add Other Address'.tr,
                                style: Theme.of(context).textTheme.displayLarge,
                              )),
                              IconButton(
                                icon: Get.locale?.languageCode == 'en'
                                    ? SvgPicture.asset(arrow_right)
                                    : Transform.rotate(
                                        angle: 3.14,
                                        child: SvgPicture.asset(arrow_right),
                                      ),
                                onPressed: () {
                                  Get.to(() => AddLocationScreen(),
                                      arguments: {'type': "add"});
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
          ),
        )));
  }
}
