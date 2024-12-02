import 'dart:ffi';

import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget sucess({required String type, String? orderId, dynamic context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 66),
    child: Column(
      children: [
        const SizedBox(
          height: 66,
        ),
        Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(starsBlue)),
        SvgPicture.asset(success),
        const SizedBox(
          height: 42,
        ),
        type == 'phoneVerified'
            ? Column(
                children: [
                  Text(
                    'Your phone number has been'.tr,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff959699),
                      fontFamily: localization == "en"
                          ? GoogleFonts.roboto().fontFamily
                          : 'DubaiFont',
                    ),
                  ),
                  Text('successfully verified'.tr,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: ConstantColors.primaryColor,
                        fontFamily: localization == "en"
                            ? GoogleFonts.roboto().fontFamily
                            : 'DubaiFont',
                      )),
                  SizedBox(
                    height: 65,
                  ),
                  FormSubmitButton(
                      disabled: false,
                      label: 'Go to Login'.tr,
                      context: context,
                      onPressed: () {
                        Get.offAll(SignInScreen());
                      }),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  type == 'card'
                      ? Text('Payment Successful '.tr,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: ConstantColors.primaryColor,
                            fontFamily: localization == "en"
                                ? GoogleFonts.roboto().fontFamily
                                : 'DubaiFont',
                          ))
                      : const SizedBox(),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      'Thank you for choosing Auto Flex.Your order was placed successfully.The service provider will confirm shortly.'
                          .tr,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff959699),
                        fontFamily: localization == "en"
                            ? GoogleFonts.roboto().fontFamily
                            : 'DubaiFont',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* Text(
                        'Order ID: '.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff959699),
                          fontFamily: localization == "en"
                              ? GoogleFonts.roboto().fontFamily
                              : 'DubaiFont',
                        ),
                      ), */
                      Text(
                        orderId ?? '',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff959699),
                          fontFamily: localization == "en"
                              ? GoogleFonts.roboto().fontFamily
                              : 'DubaiFont',
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  FormSubmitButton(
                      disabled: false,
                      label: 'Back to Home'.tr,
                      context: context,
                      onPressed: () {
                        Get.offAll(HomeScreen());
                      }),
                ],
              )
      ],
    ),
  );
}
