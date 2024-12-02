import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/locations/addLocation.dart';
import 'package:autoflex/views/vehicles/add_vehicles_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInfoPopUp extends StatelessWidget {
  final carController = Get.find<CarController>();
  final locationController = Get.find<LocationController>();
  AddInfoPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CupertinoAlertDialog(
        title: Text('Add Location & Vehicle'.tr),
        content: Text(
            'Location & Vehicle are required to show relevant service providers.\n \nPlease add your desire service location and vehicle.'
                .tr),
        actions: <Widget>[
          locationController.locations.isNotEmpty
              ? const SizedBox()
              : CupertinoDialogAction(
                  child: Text('Add Location'.tr),
                  onPressed: () {
                    // Add your sign in action here
                    Get.back();
                    Get.to(() => AddLocationScreen(),
                        arguments: {'type': 'add'}); // Close the dialog
                  },
                ),
          carController.cars.isNotEmpty
              ? const SizedBox()
              : CupertinoDialogAction(
                  child: Text(
                    'Add Vehicle'.tr,
                  ),
                  onPressed: () {
                    // Add your sign up action here
                    Get.back();
                    Get.to(() => AddVehicleScreen(),
                        arguments: {'type': 'add'}); // Close the dialog
                  },
                ),
        ],
      ),
    );
  }
}
