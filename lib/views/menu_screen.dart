import 'dart:developer';

import 'package:autoflex/controllers/Auth/logout-controller.dart';
import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/controllers/home/homeController.dart';
import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/controllers/menu/account%20settings/personal_data_controller.dart';
import 'package:autoflex/controllers/menu/orders_controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/menu-option.dart';
import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';
import 'package:autoflex/views/locations/myLocations.dart';
import 'package:autoflex/views/orders_screen.dart';
import 'package:autoflex/views/personal_details_screen.dart';
import 'package:autoflex/views/settings/account_settings_screen.dart';
import 'package:autoflex/views/settings/terms_and_conditions_screen.dart';
import 'package:autoflex/views/support/faqs_screen.dart';
import 'package:autoflex/views/support/talk_to_us_screen.dart';
import 'package:autoflex/views/vehicles/my_vehicles_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../shared/shared_preference.dart';

final SharedPreferenceController sharedPreferenceController =
    Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');

class MenuScreen extends StatelessWidget {
  final ordersController = Get.find<OrdersController>();
  LogoutController logoutController = Get.put(LogoutController());

  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> personalOptions = [
      ['Personal Details'.tr, id, PersonalDetailsScreen()],
      ['My Locations'.tr, personal, MyLocationsScreen()],
      ['My Vehicels'.tr, menuCar, MyVehiclesScreen()],
      ['My Orders'.tr, orders, OrdersScreen()]
    ];
    List<List<dynamic>> appOptions = [
      ['Account Settings'.tr, settings, const AccountSettingsScreen()],
      ['Terms & Conditions'.tr, article, const TermsScreen()]
    ];
    List<List<dynamic>> supportOptions = [
      ['Talk to Us'.tr, headset, TalkToUsScreen()],
      ['FAQs'.tr, faq, const FAQsScreen()]
    ];

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: ConstantColors.backgroundColor,
              leading: IconButton(
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
              actions: [
                InkWell(
                  onTap: () async {
                    if (Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').localization.value == 'en') {
                      print('hi');
                      Get.updateLocale(Locale('ar'));
                      sharedPreferenceController.localization.value = 'ar';
                      await sharedPreferenceController.setValue(
                          'localization', 'ar');
                   
                    } else {
                       print('hello');
                      Get.updateLocale(Locale('en'));
                      sharedPreferenceController.localization.value = 'en';
                      await sharedPreferenceController.setValue(
                          'localization', 'en');
                        
                       
                    }
                    await sharedPreferenceController.changeLocale(sharedPreferenceController.localization.value);
                    await Restart.restartApp();
                  },
                  child: Row(
                    children: [
                      Text(
                        'العربية'.tr,
                        style: TextStyle(
                            fontSize: 11,
                            color: ConstantColors.primaryColor,
                            fontFamily: localization == "en"
                                ? GoogleFonts.roboto().fontFamily
                                : 'DubaiFont',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(language),
                    ],
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  children: [
                    Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: ConstantColors.secondaryColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(9999)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 16,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: sharedPreferenceController
                                        .userData.value.data!.image !=
                                    null &&
                                sharedPreferenceController
                                    .userData.value.data!.image!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: sharedPreferenceController
                                    .userData.value.data!.image!,
                                width: 65,
                                height: 65,
                              )
                            : Image.asset(
                                "assets/images/avatar.png",
                                width: 65,
                                height: 65,
                              )),
                   
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      sharedPreferenceController
                              .userData.value.data!.fullName ??
                          sharedPreferenceController
                                  .userData.value.data!.firstName +
                              ' ' +
                              sharedPreferenceController
                                  .userData.value.data!.lastName,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                   
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      foregroundDecoration: BoxDecoration(
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: List.generate(
                          personalOptions.length,
                          (index) => MenuOption(
                              label: personalOptions[index][0],
                              icon: personalOptions[index][1],
                              onPressed: () async {
                                if (personalOptions[index][2] != null) {
                                  Get.to(() =>
                                      personalOptions[index][2] as Widget);
                                  if (personalOptions[index][0] ==
                                      'My Orders'.tr) {
                                    await ordersController.getOrdersList();
                                  }
                                }
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      foregroundDecoration: BoxDecoration(
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: List.generate(
                            appOptions.length,
                            (index) => MenuOption(
                                label: appOptions[index][0],
                                icon: appOptions[index][1],
                                onPressed: () {
                                  if (personalOptions[index][2] != null) {
                                    Get.to(
                                        () => appOptions[index][2] as Widget);
                                  }
                                })),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      foregroundDecoration: BoxDecoration(
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: List.generate(
                            supportOptions.length,
                            (index) => MenuOption(
                                label: supportOptions[index][0],
                                icon: supportOptions[index][1],
                                onPressed: () {
                                  if (personalOptions[index][2] != null) {
                                    Get.to(() =>
                                        supportOptions[index][2] as Widget);
                                  }
                                })),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      foregroundDecoration: BoxDecoration(
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SizedBox(
                        height: 60,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .isLoggedIn
                                  .value = false;

                              await Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .setBoolValue("isLoggedIn", false);
                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .removeValue();

                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .isLoggedIn
                                  .refresh();
                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .userToken
                                  .value = '';

                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .update();

                              Future.delayed(const Duration(seconds: 0),
                                  () async {
                                logoutController.logoutRequest();
                                Get.delete<HomeController>(force: true);
                                Get.delete<CarController>(force: true);
                                Get.delete<LocationController>(force: true);
                                Get.delete<CartController>(force: true);
                                Get.delete<OrdersController>(force: true);
                                Get.delete<PersonalDataController>(force: true);
                                Get.offAll(() => SignInScreen());
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero)),
                            ),
                            icon: SvgPicture.asset(logout),
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
                                        'Logout'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: ConstantColors
                                                    .secondaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Get.locale!.languageCode == 'en'
                                    ? SvgPicture.asset(
                                        navigateNext,
                                        color: ConstantColors.bodyColor,
                                      )
                                    : Transform.rotate(
                                        angle: 3.14,
                                        child: SvgPicture.asset(
                                          navigateNext,
                                          color: ConstantColors.bodyColor,
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          logoutController.loading.value ? const LoadingWidget() : const Row()
        ],
      ),
    );
  }
}
