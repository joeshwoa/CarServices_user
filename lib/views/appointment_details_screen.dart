import 'dart:developer';
import 'dart:ffi';
import 'dart:ui' as ui;
import 'package:autoflex/controllers/home/appointmentDetailsController.dart';
import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/controllers/home/provider_controller.dart';
import 'package:autoflex/shared/components/custom_radio.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/Provider_selection_screen.dart';
import 'package:autoflex/views/locations/addLocation.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:autoflex/views/vehicles/add_vehicles_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

// List<Widget> dates = [];
// List<Widget> times = [];

class AppointmentDetailsScreen extends StatelessWidget {
  final String title;

  AppointmentDetailsScreen({super.key, required this.title});
  final appointmentDetailsController = Get.put(AppointmentDetailsController());
  final carController = Get.find<CarController>();
  final locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    getDates(String title) {


      // Loop through today and the next 4 days
      for (var i = 0; i <= 4; i++) {

        appointmentDetailsController.datesWidget.value.add(
          InkWell(
            onTap: () {
              // appointmentDetailsController.getCategoryAvailibiltyRequest(appointmentDetailsController.dates[i],appointmentDetailsController.weekdays[i]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            "${appointmentDetailsController.weekdays.value[i]}\n${appointmentDetailsController.dates.value[i].toString().split('-')[2]}",
                        style: const TextStyle(
                          fontSize: 17,
                          color: ConstantColors.primaryColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ))),
            ),
          ),
        );
        appointmentDetailsController.timeSlots.add(Obx(
          () => ResponsiveGridList(
              horizontalGridSpacing: 8,
              verticalGridSpacing: 8,
              horizontalGridMargin: 16,
              verticalGridMargin: 10,
              minItemWidth: 112,
              minItemsPerRow: 3,
              maxItemsPerRow: 5,
              children: List.generate(appointmentDetailsController.times.length,
                  // appointmentDetailsController.times.value.map((time){
                  (index) {
                     bool isAfterFromTime = appointmentDetailsController.today.value.hour > int.parse(appointmentDetailsController.times[index].from.toString().split(':')[0]) ||
      (appointmentDetailsController.today.value.hour == int.parse(appointmentDetailsController.times[index].from.toString().split(':')[0]) && appointmentDetailsController.today.value.minute > int.parse(appointmentDetailsController.times[index].from.toString().split(':')[1])) ||
      (appointmentDetailsController.today.value.hour == int.parse(appointmentDetailsController.times[index].from.toString().split(':')[0]) && appointmentDetailsController.today.value.minute == int.parse(appointmentDetailsController.times[index].from.toString().split(':')[1]) && appointmentDetailsController.today.value.second >= int.parse(appointmentDetailsController.times[index].toString().split(':')[2]));
                   
                var timeSlote = InkWell(
                  onTap: () {
                    print(carController.car.value.carType!.id);
                    String dateTime =
                        '${appointmentDetailsController.weekday.value.toUpperCase()} ${appointmentDetailsController.monthDay.value.toString()}, ${appointmentDetailsController.times[index].from} - ${appointmentDetailsController.times[index].to}';
                    if (carController.car.value.name != 'Add Vehicle'.tr &&
                        locationController.location.value.type !=
                            'Add Location'.tr) {
                      print(appointmentDetailsController.times[index].id);
                      if (appointmentDetailsController
                              .times[index].availability !=
                          'Not Available') {
                        Get.off(
                            () => ProviderSelectionScreen(
                                  title: title,
                                  dateTime: dateTime,
                                  date: appointmentDetailsController
                                      .dates.value[i],
                                  day: appointmentDetailsController
                                      .weekdays.value[i]
                                      .toString()
                                      .toUpperCase(),
                                  slotId: appointmentDetailsController
                                      .times[index].id,
                                ),
                            arguments: ({
                              "categoryId": Get.arguments['categoryId'],
                              'cityId': locationController
                                  .location.value.emirateCity?.id,
                              'slotId':
                                  appointmentDetailsController.times[index].id,
                              'day': appointmentDetailsController
                                  .weekdays.value[i]
                                  .toString()
                                  .toUpperCase(),
                              'date':
                                  appointmentDetailsController.dates.value[i],
                              'car_type_id':
                                  carController.car.value.carType!.id,
                            }));
                      } else {
                        Get.snackbar("Not Available".tr,
                            "Please Select anothor appointment".tr,
                            backgroundColor: ConstantColors.errorColor,
                            colorText: Colors.white);
                      }
                    } else {
                      Get.snackbar("No Car or Adress".tr,
                          "Please Select a Vehicle and Location".tr,
                          backgroundColor: ConstantColors.errorColor,
                          colorText: Colors.white);
                    }
                  },
                  child:
                 
appointmentDetailsController.selectedDate.value == appointmentDetailsController.today.value.toString().split(' ')[0]
?isAfterFromTime?    SizedBox()               
:Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    color: appointmentDetailsController
                                .times[index].availability ==
                            'available'
                        ? ConstantColors.green
                        : appointmentDetailsController
                                    .times[index].availability ==
                                'Not Available'
                            ? const Color.fromRGBO(255, 0, 0, 0.25)
                            : const Color.fromRGBO(255, 136, 0, 0.15),
                    child: Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Center(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    '${appointmentDetailsController.slots.firstWhere((slot) => slot['id'] == appointmentDetailsController.times[index].id)['from']} - ${appointmentDetailsController.slots.firstWhere((slot) => slot['id'] == appointmentDetailsController.times[index].id)['to']} \n ${appointmentDetailsController.times[index].availability.toString().tr.toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: -0.15,
                                  color: appointmentDetailsController
                                              .times[index].availability ==
                                          'available'
                                      ? ConstantColors.primaryColor
                                      : appointmentDetailsController
                                                  .times[index].availability ==
                                              'Not Available'
                                          ? const Color(0xff440000)
                                          : const Color(0xffFF6600),
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                    ),
                  )
                  :Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    color: appointmentDetailsController
                                .times[index].availability ==
                            'available'
                        ? ConstantColors.green
                        : appointmentDetailsController
                                    .times[index].availability ==
                                'Not Available'
                            ? const Color.fromRGBO(255, 0, 0, 0.25)
                            : const Color.fromRGBO(255, 136, 0, 0.15),
                    child: Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Center(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    '${appointmentDetailsController.slots.firstWhere((slot) => slot['id'] == appointmentDetailsController.times[index].id)['from']} - ${appointmentDetailsController.slots.firstWhere((slot) => slot['id'] == appointmentDetailsController.times[index].id)['to']} \n ${appointmentDetailsController.times[index].availability.toString().tr.toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: -0.15,
                                  color: appointmentDetailsController
                                              .times[index].availability ==
                                          'available'
                                      ? ConstantColors.primaryColor
                                      : appointmentDetailsController
                                                  .times[index].availability ==
                                              'Not Available'
                                          ? const Color(0xff440000)
                                          : const Color(0xffFF6600),
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                    ),
                  ),
                );

                // appointmentDetailsController.timeSlots.add(timeSlote);
                return timeSlote;
              })),
        ));
      }
    }

    getDates(title);
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: ConstantColors.backgroundColor,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              color: ConstantColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Text(
                'Close'.tr,
                style: const TextStyle(
                  fontSize: 15,
                  color: ConstantColors.secondaryColor,
                ),
              ),
              onPressed: () {
                Get.off(() => HomeScreen());
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Theme(
                      data: ThemeData(dividerColor: Colors.transparent),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ExpansionTile(
                          iconColor: ConstantColors.bodyColor,
                          collapsedIconColor: ConstantColors.bodyColor,
                          initiallyExpanded: true,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          title: Text(
                            'Service Vehicle'.tr,
                            style: const TextStyle(
                              fontSize: 17,
                              color: ConstantColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              child: Obx(() => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: carController.cars
                                        .map((car) => CustomRadio(
                                            value: car.id,
                                            title: Text(
                                              '${car.carBrand!.name!.capitalize!} ${car.carModel?.name!.capitalize!}',
                                              style: TextStyle(
                                                color: carController
                                                            .car.value.id ==
                                                        car.id
                                                    ? ConstantColors
                                                        .primaryColor
                                                    : const Color(0xFF717276),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${car.plateCode} - ${car.plateNumber!} (${car.color!.capitalize})',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: carController
                                                            .car.value.id ==
                                                        car.id
                                                    ? ConstantColors
                                                        .primaryColor
                                                    : const Color(0xFF717276),
                                                fontSize: 11,
                                              ),
                                            ),
                                            groupValue:
                                                carController.car.value.id,
                                            onChanged: (value) {
                                              carController.changeCar(value!);
                                            },
                                            customIcon: 'car'))
                                        .toList(),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: TextButton.icon(
                                  onPressed: () {
                                    Get.to(() => AddVehicleScreen(),
                                        arguments: {'type': 'add'});
                                  },
                                  icon: SvgPicture.asset(add),
                                  label: Text(
                                    'Add Vehicle'.tr,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: ConstantColors.secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Theme(
                      data: ThemeData(dividerColor: Colors.transparent),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ExpansionTile(
                          iconColor: ConstantColors.bodyColor,
                          collapsedIconColor: ConstantColors.bodyColor,
                          initiallyExpanded: true,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          title: Text(
                            'Service Address'.tr,
                            style: const TextStyle(
                              fontSize: 17,
                              color: ConstantColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              child: Obx(() => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: locationController.locations
                                        .map((location) => CustomRadio(
                                            value: location.id,
                                            title: Text(
                                              location.type!.capitalize!,
                                              style: TextStyle(
                                                color: locationController
                                                            .location
                                                            .value
                                                            .id ==
                                                        location.id
                                                    ? ConstantColors
                                                        .primaryColor
                                                    : const Color(0xFF717276),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${location.address?.capitalizeFirst} ${location.emirate?.name ?? ''}, ${location.emirateCity?.name ?? ''}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: locationController
                                                            .location
                                                            .value
                                                            .id ==
                                                        location.id
                                                    ? ConstantColors
                                                        .primaryColor
                                                    : const Color(0xFF717276),
                                                fontSize: 11,
                                              ),
                                            ),
                                            groupValue: locationController
                                                .location.value.id,
                                            onChanged: (value) {
                                              locationController
                                                  .changelocation(value!);
                                            },
                                            customIcon:
                                                '${location.type!.toLowerCase()}_small'))
                                        .toList(),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: TextButton.icon(
                                  onPressed: () {
                                    Get.to(AddLocationScreen(),
                                        arguments: {'type': 'add'});
                                  },
                                  icon: SvgPicture.asset(add),
                                  label: Text(
                                    'Add Address'.tr,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: ConstantColors.secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Get.locale!.languageCode == 'en'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      'Select date & time'.tr,
                      style: const TextStyle(
                          fontSize: 17,
                          color: ConstantColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: !appointmentDetailsController.isInitialized.value ||
                          appointmentDetailsController.loading.value
                      // The TabController is not initialized yet
                      ? const Center(child: CircularProgressIndicator())
                      : DefaultTabController(
                          initialIndex: 0,
                          length: appointmentDetailsController.dates.length,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 0, right: 0),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(227, 228, 229,
                                      1), // Set your desired color
                                ),
                                child: TabBar(
                                  //             onTap: (i){
                                  //               print(i);
                                  // appointmentDetailsController.getCategoryAvailibiltyRequest(appointmentDetailsController.dates[i],appointmentDetailsController.weekdays[i]);

                                  //             },
                                  controller: appointmentDetailsController
                                      .tabController,
                                  tabAlignment: TabAlignment.center,
                                  isScrollable:
                                      true, // Uncomment if you want scrollable tabs
                                  indicatorColor: ConstantColors.secondaryColor,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: appointmentDetailsController
                                      .datesWidget.value,
                                ),
                              ),
                              Container(
                                height: 360,
                                child: TabBarView(
                                    // physics: const NeverScrollableScrollPhysics(),
                                    controller: appointmentDetailsController
                                        .tabController,
                                    children: appointmentDetailsController
                                        .timeSlots.value),
                              )
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
