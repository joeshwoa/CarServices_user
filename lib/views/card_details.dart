import 'dart:io';

import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/home_screen.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:telr_payment_gateway_plus/telr_payment_gateway_plus.dart';

class CardDetailsScreen extends StatelessWidget {
  final double amount;
  const CardDetailsScreen({super.key, required this.amount});

  // Future<String?> getDeviceId() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  //   if (Platform.isAndroid) {
  //     return await deviceInfo.androidInfo.then((value) {
  //       return value.id; // This is the unique device ID on Android
  //     },);
  //   } else if (Platform.isIOS) {
  //     deviceInfo.iosInfo.then((value) {
  //       value.identifierForVendor; // This is the unique device ID on iOS
  //     },);
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: ConstantColors.backgroundColor,
        title: Text(
          "PAYMENT".tr,
          style: const TextStyle(
            color: ConstantColors.primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.17,
          ),
        ),
        leading: IconButton(
            icon: SvgPicture.asset(arrowBack),
            onPressed: () {
              Get.back();
            }),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Payment Amount: '.tr,
                    style: const TextStyle(
                      color: Color(0xFF002F6C),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.17,
                    ),
                  ),
                  TextSpan(
                    text: '${'AED'.tr} $amount',
                    style: const TextStyle(
                      color: Color(0xFF002F6C),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.17,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name on Card'.tr,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                hintStyle: const TextStyle(
                    color: ConstantColors.hintColor,
                    fontWeight: FontWeight.normal),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: ConstantColors.hintColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: ConstantColors.hintColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide:
                      const BorderSide(color: ConstantColors.secondaryColor),
                ),
              ),
              onChanged: (value) {
                // Handle search input change
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Card Number'.tr,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                hintStyle: const TextStyle(
                    color: ConstantColors.hintColor,
                    fontWeight: FontWeight.normal),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: ConstantColors.hintColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(color: ConstantColors.hintColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide:
                      const BorderSide(color: ConstantColors.secondaryColor),
                ),
              ),
              onChanged: (value) {
                // Handle search input change
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Expiry Date'.tr,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      hintStyle: const TextStyle(
                          color: ConstantColors.hintColor,
                          fontWeight: FontWeight.normal),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide:
                            const BorderSide(color: ConstantColors.hintColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide:
                            const BorderSide(color: ConstantColors.hintColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: const BorderSide(
                            color: ConstantColors.secondaryColor),
                      ),
                    ),
                    onChanged: (value) {
                      // Handle search input change
                    },
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Security Code'.tr,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      hintStyle: const TextStyle(
                          color: ConstantColors.hintColor,
                          fontWeight: FontWeight.normal),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide:
                            const BorderSide(color: ConstantColors.hintColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide:
                            const BorderSide(color: ConstantColors.hintColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: const BorderSide(
                            color: ConstantColors.secondaryColor),
                      ),
                    ),
                    onChanged: (value) {
                      // Handle search input change
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  // String? deviceId = await getDeviceId();
                  //TelrPaymentGatewayPlus.pay(context: context, APIKey: 'c9BxF#vk8hw^qZJZ', storeID: '28479', phoneType: Platform.isAndroid?PhoneType.android:PhoneType.ios, appUserId: '123', testMode: true, cartId: '123', customerEmail: 'test@telr.com', customerPhone: '0123456789', customerCountryCode: 'EGY', customerAddress: 'customerAddress', currencyCode: 'AED', amount: 200, deviceID: deviceId??'');
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                      ConstantColors.primaryColor),
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
                  side: const MaterialStatePropertyAll(
                      BorderSide(color: ConstantColors.primaryColor)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                ),
                child: Text(
                  'PAY'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.17,
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
