import 'dart:developer';

import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/controllers/home/homeController.dart';
import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/controllers/menu/orders_controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/models/addresses.dart' as adress;
import 'package:autoflex/shared/shared_preference.dart';
import 'package:badges/badges.dart' as badges;
import 'package:autoflex/models/locationModel.dart';
import 'package:autoflex/models/vehiclesModel.dart';
import 'package:autoflex/shared/components/account_pop-up.dart';
import 'package:autoflex/shared/components/add_info_pop-up.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/views/appointment_details_screen.dart';
import 'package:autoflex/views/cart_screen.dart';
import 'package:autoflex/views/menu_screen.dart';
import 'package:autoflex/views/services_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../models/carModel.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home-screen';
  HomeScreen({super.key});
  final HomeController homeController =
      Get.put(HomeController(), permanent: true);
  final CarController carController = Get.put(CarController(), permanent: true);
  final LocationController locationController =
      Get.put(LocationController(), permanent: true);
  final CartController cartController =
      Get.put(CartController(), permanent: true);
  final OrdersController ordersController =
      Get.put(OrdersController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Obx(
            () => Scaffold(
              body: Stack(
                        children: [
              Scaffold(
                  backgroundColor: ConstantColors.backgroundColor,
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 0.0,
                    backgroundColor: ConstantColors.backgroundColor,
                    leading: IconButton(
                      icon: SvgPicture.asset(menu),
                      onPressed: () {
                        if (Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
                            .isLoggedIn
                            .value) {
                          Get.to(() => MenuScreen());
                        } else {
                          Get.dialog(
                            const AccountPopUp(),
                          );
                        }
                      },
                    ),
                    title: SvgPicture.asset(logo),
                    actions: [
                      Obx(() => IconButton(
                        icon: cartController.cart.isEmpty
                            ? SvgPicture.asset(cartOutlined)
                            : badges.Badge(
                          badgeStyle: const badges.BadgeStyle(
                              badgeColor: ConstantColors.secondaryColor),
                          badgeContent: Text(
                            cartController.cart.length.toString(),
                            style: const TextStyle(
                                fontSize: 8, color: Colors.white),
                          ),
                          child: SvgPicture.asset(shoppingCart),
                        ),
                        onPressed: () {
                          Get.to(() => CartScreen());
                        },
                      )),
                      Obx(() => IconButton(
                        icon: SvgPicture.asset(homeController.unseenMessages.value?notificationsUnread:notificationsRead, color: ConstantColors.secondaryColor,),
                        onPressed: () async {
                          homeController.showNotification.value = !homeController.showNotification.value;
                          if(homeController.showNotification.value) {
                            await homeController.getNotifications();
                            homeController.readAllNotifications();
                          }
                        },
                      )),
                    ],
                  ),
                  body: Obx(() {
                    //   print(carController.cars.length);
                    //   print(locationController.locations.length);
                    //  carController.cars.isEmpty ||
                    // locationController.locations.isEmpty
                    //       ?
                    //     WidgetsBinding.instance.addPostFrameCallback((_) {
                    //       Get.dialog(const AddInfoPopUp());
                    //     }):SizedBox();
              
                    return SingleChildScrollView(
                      child: Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.44,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                      Border.all(color: ConstantColors.borderColor),
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!Get.find<SharedPreferenceController>(
                                            tag: 'tagsAreEverywhere')
                                            .isLoggedIn
                                            .value) {
                                          Get.dialog(const AccountPopUp());
                                        } else {
                                          if (locationController.locations.isEmpty) {
                                            Get.dialog(AddInfoPopUp());
                                          }
                                        }
                                      },
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(0, 14, 8, 0),
                                              child: locationController
                                                  .location.value.type ==
                                                  'Add Location'.tr
                                                  ? SvgPicture.asset(location)
                                                  : SvgPicture.asset(locationSelected),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(0, 7, 8, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${locationController.location.value.type!.capitalizeFirst}',
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                        ConstantColors.primaryColor,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      locationController
                                                          .location.value.type ==
                                                          'Add Location'.tr
                                                          ? 'Area, Emirate'.tr
                                                          : '${locationController.location.value.address?.capitalizeFirst} ${locationController.location.value.emirate?.name}, ${locationController.location.value.emirateCity?.name}',
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: locationController.location
                                                            .value.type ==
                                                            'Add Location'.tr
                                                            ? ConstantColors.hintColor
                                                            : ConstantColors.bodyColor,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: locationController.locations
                                            .map<DropdownMenuItem<String>>(
                                                (adress.Datum location) {
                                              return DropdownMenuItem<String>(
                                                value: location.id.toString(),
                                                child: Text(
                                                  location.type!.capitalizeFirst!,
                                                  style: const TextStyle(
                                                    color: ConstantColors.primaryColor,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (String? id) {
                                          if (id != null) {
                                            locationController
                                                .changelocation(int.parse(id));
                                          }
                                        },
                                        icon: SvgPicture.asset(arrowDown),
                                        underline: const SizedBox(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.44,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                      Border.all(color: ConstantColors.borderColor),
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!Get.find<SharedPreferenceController>(
                                            tag: 'tagsAreEverywhere')
                                            .isLoggedIn
                                            .value) {
                                          Get.dialog(const AccountPopUp());
                                        } else {
                                          if (locationController.locations.isEmpty) {
                                            Get.dialog(AddInfoPopUp());
                                          }
                                        }
                                      },
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(0, 14, 8, 0),
                                              child: carController.car.value.name ==
                                                  'Add Vehicle'.tr
                                                  ? SvgPicture.asset(car)
                                                  : SvgPicture.asset(carSelected),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(0, 7, 8, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      carController.car.value.name ==
                                                          'Add Vehicle'.tr
                                                          ? 'Add Vehicle'.tr
                                                          : '${carController.car.value.carBrand?.name?.capitalize} ${carController.car.value.carModel?.name?.capitalize}',
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                        ConstantColors.primaryColor,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      carController.car.value.name ==
                                                          'Add Vehicle'.tr
                                                          ? 'Make & Model'.tr
                                                          : '${carController.car.value.plateCode} - ${carController.car.value.plateNumber}',
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: carController
                                                            .car.value.name ==
                                                            'Add Vehicle'.tr
                                                            ? ConstantColors.hintColor
                                                            : ConstantColors.bodyColor,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: carController.cars
                                            .map<DropdownMenuItem<String>>((Datum car) {
                                          return DropdownMenuItem<String>(
                                            value: car.id.toString(),
                                            child: Text(
                                              '${car.carBrand?.name?.capitalize} ${car.carModel?.name?.capitalize}',
                                              style: const TextStyle(
                                                color: ConstantColors.primaryColor,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? id) {
                                          if (id != null) {
                                            carController.changeCar(int.parse(id));
                                          }
                                        },
                                        icon: SvgPicture.asset(arrowDown),
                                        underline: const SizedBox(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 110 / 50,
                                ),
                                items: [
                                  Container(
                                      width: 330,
                                      height: 160,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/carousel_ad.png'),
                                              fit: BoxFit.cover)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: Get.locale!.languageCode == 'en'
                                                ? const EdgeInsets.fromLTRB(15, 30, 0, 0)
                                                : const EdgeInsets.fromLTRB(0, 30, 15, 0),
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: 'NEW\n'.tr,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 11.0,
                                                      color: Colors.white,
                                                      height:
                                                      Get.locale!.languageCode == 'en'
                                                          ? null
                                                          : 0.5,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'MECHANICAL\n'.tr,
                                                    style: TextStyle(
                                                      fontSize:
                                                      14.0, // Bigger font size for "Mechanical"
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      height:
                                                      Get.locale!.languageCode == 'en'
                                                          ? null
                                                          : 1.5,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'SERVICES\nAVAILABLE'.tr,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 11.0,
                                                      color: Colors.white,
                                                      height:
                                                      Get.locale!.languageCode == 'en'
                                                          ? null
                                                          : 1.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: const ButtonStyle(
                                              shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadiusDirectional.only(
                                                    topEnd: Radius.circular(8),
                                                    bottomEnd: Radius.circular(8),
                                                  ),
                                                ),
                                              ),
                                              backgroundColor: MaterialStatePropertyAll(
                                                Color.fromRGBO(41, 43, 51, 1),
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.to(() => ServicesScreen());
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize
                                                  .min, // Ensure the Row takes minimum space
                                              children: [
                                                Text(
                                                  'EXPLORE'.tr,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0,
                                                    color: Color(
                                                        0xFF00B0FF), // Replace with ConstantColors.secondaryColor if needed
                                                  ),
                                                ),
                                                const SizedBox(
                                                    width:
                                                    20), // Custom spacing between icon and label
                                                Get.locale?.languageCode == 'en'
                                                    ? SvgPicture.asset(arrowRight)
                                                    : Transform.rotate(
                                                  angle: 3.14,
                                                  child:
                                                  SvgPicture.asset(arrowRight),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              !homeController.loading.value
                                  ? Container(
                                height: MediaQuery.of(context).size.height / 2.35,
                                child: GridView.builder(
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      crossAxisCount: 2,
                                      childAspectRatio: (1 / .6)),
                                  itemBuilder: (context, i) => InkWell(
                                    onTap: () {
                                      if (!Get.find<SharedPreferenceController>(
                                          tag: 'tagsAreEverywhere')
                                          .isLoggedIn
                                          .value) {
                                        Get.dialog(const AccountPopUp());
                                      } else {
                                        carController.cars.isEmpty ||
                                            locationController.locations.isEmpty
                                            ? WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          Get.dialog(AddInfoPopUp());
                                        })
                                            : Get.off(
                                                () => AppointmentDetailsScreen(
                                              title: homeController
                                                  .categories[i].name
                                                  .toString(),
                                            ),
                                            arguments: ({
                                              "categoryId": homeController
                                                  .categories[i].id as int,
                                              'cityId': locationController
                                                  .location
                                                  .value
                                                  .emirateCity
                                                  ?.id,
                                              "carTypeId": carController
                                                  .car.value.carType!.id
                                            }));
                                      }
                                    },
                                    child: Container(
                                      height: 88,
                                      padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ConstantColors.borderColor),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          // SvgPicture.asset(engineWorks),
                                          CachedNetworkImage(
                                            imageUrl: homeController
                                                .categories[i].logoUrl
                                                .toString(),
                                            width: 24,
                                            height: 24,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget: (context, url, error) =>
                                            const Icon(Icons.error,
                                                color: Color.fromARGB(
                                                    255, 17, 14, 14)),
                                          ),
                                          Text(
                                            homeController.categories[i].name
                                                .toString()
                                                .toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                              overflow: TextOverflow.clip,
                                            ),
                                            maxLines:
                                            Get.locale!.languageCode == 'en'
                                                ? null
                                                : 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  itemCount: 6,
                                ),
                              )
                                  : Container(
                                height: MediaQuery.of(context).size.height / 2.5,
                                child: GridView.builder(
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      crossAxisCount: 2,
                                      childAspectRatio: (1 / .6)),
                                  itemBuilder: (context, i) => Container(
                                    height: 90,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            height: 90,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  itemCount: 6,
                                ),
                              ),
                              homeController.categories.length >= 7
                                  ? SizedBox(
                                height: 56,
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      if (!Get.find<SharedPreferenceController>(
                                          tag: 'tagsAreEverywhere')
                                          .isLoggedIn
                                          .value) {
                                        Get.dialog(const AccountPopUp());
                                      } else {
                                        carController.cars.isEmpty ||
                                            locationController.locations.isEmpty
                                            ? WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          Get.dialog(AddInfoPopUp());
                                        })
                                            : Get.off(
                                                () => AppointmentDetailsScreen(
                                              title: homeController
                                                  .categories[6].name
                                                  .toString(),
                                            ),
                                            arguments: ({
                                              "categoryId": homeController
                                                  .categories[6].id as int,
                                              'cityId': locationController
                                                  .location
                                                  .value
                                                  .emirateCity
                                                  ?.id,
                                              "carTypeId": carController
                                                  .car.value.carType!.id
                                            }));
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                              color: ConstantColors.borderColor)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          )),
                                    ),
                                    icon: CachedNetworkImage(
                                      imageUrl: homeController.categories[6].logoUrl
                                          .toString(),
                                      width: 24,
                                      height: 24,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error,
                                          color:
                                          Color.fromARGB(255, 17, 14, 14)),
                                    ),
                                    label: Row(
                                      children: [
                                        const SizedBox(
                                            width:
                                            8), // Adjust the width for desired space between icon and label
                                        Text(
                                          homeController.categories[6].name
                                              .toString()
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                            overflow: TextOverflow.clip,
                                          ),
                                          maxLines: Get.locale!.languageCode == 'en'
                                              ? null
                                              : 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 56,
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      /* if(userLoggedIn){
                                              Get.dialog(const AccountPopUp(),
                                                barrierDismissible: false);
                                            } else {
                                              get to
                                            } */
                                      Get.to(() => ServicesScreen());
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                      side: MaterialStateProperty.all(const BorderSide(
                                          color: ConstantColors.borderColor)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          )),
                                    ),
                                    icon: SvgPicture.asset(steppers),
                                    label: Row(
                                      children: [
                                        const SizedBox(
                                            width:
                                            8), // Adjust the width for desired space between icon and label
                                        Text('EXPLORE ALL SERVICES'.tr,
                                            style:
                                            Theme.of(context).textTheme.bodyMedium),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  })),
              if(homeController.showNotification.value)Align(
                child: Container(
                  decoration: BoxDecoration(
                      color: ConstantColors.backgroundColor,
                      border: Border.all(
                          width: 2,
                          color: ConstantColors.primaryColor
                      ),
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(0),
                          bottomEnd: Radius.circular(16),
                          bottomStart: Radius.circular(16),
                          topStart: Radius.circular(16)
                      )
                  ),
                  margin: EdgeInsetsDirectional.only(top: 83, end: 30, start: 10),
                  padding: EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for(int i = 0; i < homeController.getNotificationsRequest!.data!.length; i++)...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 12),
                            decoration: BoxDecoration(
                                color: ConstantColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(circle_notifications),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          homeController.getNotificationsRequest!.data![i].title??'',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: ConstantColors.primaryColor,
                                              fontFamily:
                                              GoogleFonts.roboto().fontFamily,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          homeController.getNotificationsRequest!.data![i].body??'',
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: ConstantColors.primaryColor,
                                              fontFamily:
                                              GoogleFonts.roboto().fontFamily,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                        if(homeController.getNotificationsRequest!.data!.isEmpty) Text(
                          'No new notifications'.tr,
                          style: TextStyle(
                              fontSize: 13,
                              color: ConstantColors.primaryColor,
                              fontFamily:
                              GoogleFonts.roboto().fontFamily,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                alignment: localization != "en" ? Alignment.topRight:Alignment.topLeft,
              ),
                        ],
                      ),
            )
    );
  }
}
