import 'dart:developer';

import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/controllers/menu/orders_controller.dart';
import 'package:autoflex/shared/components/cart_item.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/Payment_screen.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:autoflex/views/provider_selection_screen.dart';
import 'package:autoflex/views/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: ConstantColors.backgroundColor,
              title: Text(
                'CART'.tr,
                style: const TextStyle(
                  color: ConstantColors.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.17,
                ),
              ),
              leading: IconButton(
                  icon: Get.locale?.languageCode == 'en'
                      ? SvgPicture.asset(arrowBack)
                      : Transform.rotate(
                          angle: 3.14,
                          child: SvgPicture.asset(arrowBack),
                        ),
                  onPressed: () {
                    /* for (var addOn in cartController.boughtAddOns) {
                      inspect(addOn);
                      cartController.total.value =
                          cartController.total.value - (addOn.price ?? 0.0);
                    }
                    print(cartController.total.value);
                    cartController.disabledAddOns.clear();
                    cartController.boughtAddOns.clear(); */
                    Get.offAll(() => HomeScreen());
                  }),
            ),
            bottomNavigationBar:
                // cartController.grandTotal.value == 0.0 ||
                cartController.cart.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        child: Container(
                            decoration: const BoxDecoration(
                                color: ConstantColors.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 52,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => PaymentScreen(
                                        vat: cartController.totalTax.value,
                                        subTotal:
                                            cartController.grandTotal.value,
                                        items: cartController.cart.value,
                                      ));
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(payment),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'MAKE ORDER '.tr,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: -0.15,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '( ${'AED'.tr} ${cartController.grandTotal})',
                                                  style: const TextStyle(
                                                    color: Color(0xFFC8C9CC),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: -0.15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
            body: cartController.cart.length > 0
                ? SingleChildScrollView(
                    child: Obx(
                      () {
                        var index = -1;
                        return Column(
                          children: [
                            ...cartController.cart.map<Widget>((item) {
                              DateTime dateTime = DateTime.parse(item.date!);
                              DateTime now = DateTime.now();
                              String formattedDate =
                                  DateFormat('MMM d').format(dateTime);
                              // bool isDateValid = dateTime.isAfter(now) ||
                              //     (dateTime.year == now.year &&
                              //         dateTime.month == now.month &&
                              //         dateTime.day == now.day &&
                              //         dateTime.isBefore(now));
                              // bool isTimeValid = true;
                              // var dateFormat = DateFormat
                              //     .jm();

                              // try {
                              //   var fromTimeStr = cartController.slots
                              //       .firstWhere((slot) =>
                              //           slot['id'] == item.slotId)['from'].toString();

                              //   var toTimeStr = cartController.slots
                              //       .firstWhere((slot) =>
                              //           slot['id'] == item.slotId)['to'].toString();

                              // print('Parsing time: from $fromTimeStr to $toTimeStr');
                              //                               DateTime fromTime =
                              //                                   dateFormat.parse(fromTimeStr);
                              //                               DateTime toTime = dateFormat.parse(toTimeStr);
                              //                               fromTime = DateTime(now.year, now.month,
                              //                                   now.day, fromTime.hour, fromTime.minute);
                              //                               toTime = DateTime(now.year, now.month, now.day,
                              //                                   toTime.hour, toTime.minute);

                              //                               if (now.isAfter(toTime)) {
                              //                                 isTimeValid = false;
                              //                               }
                              //                             } catch (e) {
                              //                               print("Error parsing time: $e");
                              //                               isTimeValid = false;
                              //                             }
                              index++;
                              // if (!isDateValid || isDateValid && !isTimeValid) {
                              //   return Text('asd');
                              // } else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: Column(
                                  children: [
                                    CartItem(
                                      tax: double.parse(item.taxPercent!) / 100,
                                      index: index,
                                      car: item.vehicle != null
                                          ? '${item.vehicle?.carBrand?.name ?? ''} ${item.vehicle?.carModel?.name ?? ''} - ${item.vehicle?.year ?? ''} (${item.vehicle?.color ?? ''})'
                                          : 'Missing or Deleted Vehicle'.tr,
                                      id: item.id!.toString(),
                                      providerLogo:
                                          item.companyLog ?? providerLogo,
                                      //  item.providerLogo! addVehicleController.models.firstWhere((model) => model.id == addVehicleController.selectedModel.value).name
                                      date:
                                          "$formattedDate, ${cartController.slots.firstWhere((slot) => slot['id'] == item.slotId)['from']} - ${cartController.slots.firstWhere((slot) => slot['id'] == item.slotId)['to']}",
                                      price: double.parse(item!.price!),
                                      name: item.name!,
                                      addOns: item.addOns!,
                                    )
                                  ],
                                ),
                              );
                              // }
                            }),
                            /*  Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ConstantColors.borderColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Promo code',
                                        style: TextStyle(
                                          color: Color(0xFF45464C),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: SizedBox(
                                            height: 45,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                hintText: 'Enter Promo Code'.tr,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                hintStyle: const TextStyle(
                                                    color: ConstantColors
                                                        .hintColor,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: ConstantColors
                                                          .hintColor),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: ConstantColors
                                                          .hintColor),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: ConstantColors
                                                          .secondaryColor),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                // Handle search input change
                                              },
                                            ),
                                          )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: OutlinedButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      const MaterialStatePropertyAll(
                                                          Color(0xFF00A9DF)),
                                                  minimumSize:
                                                      const MaterialStatePropertyAll(
                                                          Size.zero),
                                                  padding:
                                                      const MaterialStatePropertyAll(
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal: 12)),
                                                  side: const MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: ConstantColors
                                                              .secondaryColor)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                child: const Text(
                                                  'APPLY'.tr, // Assuming cost is a variable containing the price
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: -0.17,
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ), */
                            Container(
                              height: 76,
                              width: double.infinity,
                              padding: const EdgeInsets.all(
                                  12.0), // Add padding for better responsiveness
                              child: TextButton(
                                onPressed: () {
                                  cartController.disabledAddOns.clear();
                                  cartController.boughtAddOns.clear();
                                  Get.to(() => ServicesScreen());
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                      color: ConstantColors.borderColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          16.0), // Text color// Button background color
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(cross), // Your icon here
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Add more services'.tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xFF717276),
                                            fontSize: 15,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      'Cart is Empty'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF717276),
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.15,
                      ),
                    ),
                  ),
          ),
          cartController.loading.value ? const LoadingWidget() : Row()
        ],
      ),
    );
  }
}
