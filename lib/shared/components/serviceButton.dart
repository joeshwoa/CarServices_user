import 'package:autoflex/shared/components/account_pop-up.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/appointment_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/home/carController.dart';
import '../../controllers/home/locationController.dart';
import 'add_info_pop-up.dart';

final CarController carController = Get.find();
final LocationController locationController = Get.find();
createButton(String label, String icon, int categoryId) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10),
    height: 60,
    child: FractionallySizedBox(
      widthFactor: 1,
      child: OutlinedButton.icon(
        onPressed: () {
          if (!Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
              .isLoggedIn
              .value) {
            Get.dialog(const AccountPopUp());
          } else {
            carController.cars.isEmpty || locationController.locations.isEmpty
                ? WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.dialog(AddInfoPopUp());
                  })
                : Get.offAll(
                    () => AppointmentDetailsScreen(
                          title: label,
                        ),
                    arguments: ({
                      "categoryId": categoryId,
                      'cityId':
                          locationController.location.value.emirateCity?.id,
                      'carTypeId': carController.car.value.carType!.id
                    }));
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          side: MaterialStateProperty.all(
              const BorderSide(color: ConstantColors.borderColor)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        ),
        icon: CachedNetworkImage(
          imageUrl: icon,
          width: 24,
          height: 24,
        ),
        // SvgPicture.asset(icon),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  const SizedBox(
                      width:
                          8), // Adjust the width for desired space between icon and label
                  Text(
                    label,
                    style: TextStyle(
                      height: Get.locale!.languageCode == 'en' ? null : 4.5,
                      fontSize: 11,
                      color: ConstantColors.bodyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Get.locale!.languageCode == 'en'
                ? SvgPicture.asset(
                    navigateNext,
                    color: ConstantColors.secondaryColor,
                  )
                : Transform.rotate(
                    angle: 3.14,
                    child: SvgPicture.asset(
                      navigateNext,
                      color: ConstantColors.secondaryColor,
                    ),
                  )
          ],
        ),
      ),
    ),
  );
}
