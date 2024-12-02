import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/menu/vehicles/add_vehicle_controller.dart';
import 'package:autoflex/controllers/menu/vehicles/edit_vehicle_controller.dart';
import 'package:autoflex/shared/components/location_vehicle_radio.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/views/locations/addLocation.dart';
import 'package:autoflex/views/vehicles/add_vehicles_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../shared/components/custom_radio.dart';
import '../../styles/icons_assets.dart';

class MyVehiclesScreen extends StatelessWidget {
  MyVehiclesScreen({super.key});
  final carController = Get.find<CarController>();
  final addVehicleController = Get.put(AddVehicleController());
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
            child: Text('MY VEHICLES'.tr,
                style: Theme.of(context).textTheme.titleLarge),
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(addCircle),
              onPressed: () {
                Get.to(() => AddVehicleScreen(), arguments: {'type': 'add'});
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
            child: carController.cars.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: carController.cars
                              .map(
                                (car) => LocationVehicleRadio(
                                    type: 'vehicle',
                                    screenName: 'myVehicles',
                                    value: car.id,
                                    title: Text(
                                        '${car.carBrand!.name!.capitalize!} ${car.carModel?.name!.capitalize!}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${car.year},${car.color!.capitalize}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                          maxLines: 3,
                                        ),
                                        Text(
                                          '${car.plateCode} - ${car.plateNumber!}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                          maxLines: 3,
                                        )
                                      ],
                                    ),
                                    groupValue: carController.car.value.id,
                                    onChanged: (value) {
                                      carController.changeCar(value!);
                                    },
                                    //not valid in arabic(NOT FIXED YET)
                                    customIcon: car.carType!.name == 'Van' ||
                                            car.carType!.name == 'SUV'
                                        ? 'suv7_large'
                                        : car.carType!.name == 'Motorcycle'
                                            ? 'motorcycle_large'
                                            : 'sedan_large',
                                    editIcon: 'border_color',
                                    edit: () {
                                      Get.to(() => AddVehicleScreen(),
                                          arguments: {
                                            'type': 'edit',
                                            'id': car.id
                                          });
                                    }),
                              )
                              .toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              SvgPicture.asset(addVehicle),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: Text(
                                'Add Another Vehicle'.tr,
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
                                  Get.delete<AddVehicleController>();
                                  Get.put(AddVehicleController());
                                  Get.to(() => AddVehicleScreen(),
                                      arguments: {'type': 'add'});
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
                              SvgPicture.asset(car),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                'Add Your First Vehicle'.tr,
                                style: Theme.of(context).textTheme.displayLarge,
                              )),
                              IconButton(
                                icon: SvgPicture.asset(arrow_right),
                                onPressed: () {
                                  Get.to(() => AddVehicleScreen(),
                                      arguments: {'type': 'add'});
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
          ),
        )));
  }
}
