import 'package:autoflex/controllers/Auth/social-sign-up-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialSignUpScreen extends StatelessWidget {
  SocialSignUpScreen({super.key});
  final SocialSignUpController controller = Get.find<SocialSignUpController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: ConstantColors.backgroundColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: ConstantColors.backgroundColor,
            leading: const Text(''),
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsetsDirectional.only(top: 16.0),
              child: Text('SOCIAL SIGN UP'.tr,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsetsDirectional.only(end: 16.0, top: 16),
            //     child: InkWell(
            //         onTap: () => {},
            //         child: Text(
            //           'Skip'.tr,
            //           style: TextStyle(
            //               fontSize: 15,
            //               fontWeight: FontWeight.w400,
            //               color: ConstantColors.secondaryColor,
            //               height: 1.2,
            //               overflow: TextOverflow.ellipsis,
            //               fontFamily: localization == "en"
            //                   ? GoogleFonts.roboto().fontFamily
            //                   : 'DubaiFont'),
            //         )),
            //   )
            // ],
          ),
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                      key: controller.socialSignUpFormKey,
                      child: Column(children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Stack(
                          children: [
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: textField(
                                hintStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                hint: 'Phone Number'.tr,
                                context: context,
                                keyboardType: TextInputType.phone,
                                controller: controller.phoneController,
                                isPassword: false,
                                change: (value) {
                                  controller.isPlaceholderVisible.value = false;
                                  if (!value.startsWith("+971")) {
                                    controller.phoneController.text = "+971";
                                    controller.phoneController.selection =
                                        TextSelection.fromPosition(
                                      TextPosition(
                                          offset: controller
                                              .phoneController.text.length),
                                    );
                                  }
                                },
                                validate: (value) {
                                  return Validations.validatePhone(
                                      value!, context);
                                },
                                disabled: false,
                              ),
                            ),
                            controller.isPlaceholderVisible.value
                                ? Positioned(
                                    left: 50,
                                    top: 16,
                                    bottom: 16,
                                    child: Text(
                                      'Phone number'.tr,
                                      style: const TextStyle(
                                          color: ConstantColors.hintColor),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        controller.showwhatsApp.value
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Stack(
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: textField(
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                          hint: 'Whats App Number'.tr,
                                          context: context,
                                          keyboardType: TextInputType.phone,
                                          controller:
                                              controller.whatsappController,
                                          isPassword: false,
                                          change: (value) {
                                            controller
                                                .iswhatsAppPlaceholderVisible
                                                .value = false;
                                            if (!value.startsWith("+971")) {
                                              controller.whatsappController
                                                  .text = "+971";
                                              controller.whatsappController
                                                      .selection =
                                                  TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: controller
                                                        .whatsappController
                                                        .text
                                                        .length),
                                              );
                                            }
                                          },
                                          validate: (value) {
                                            return Validations.validatePhone(
                                                value!, context);
                                          },
                                          disabled: false,
                                        ),
                                      ),
                                      controller.iswhatsAppPlaceholderVisible
                                              .value
                                          ? Positioned(
                                              left: 50,
                                              top: 16,
                                              bottom: 16,
                                              child: Text(
                                                'Whats App Number'.tr,
                                                style: const TextStyle(
                                                    color: ConstantColors
                                                        .hintColor),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  )
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: controller.showwhatsApp.value
                                            ? ConstantColors.secondaryColor
                                            : const Color(0xffC8C9CC))),
                                child: Checkbox(
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    focusColor: ConstantColors.secondaryColor,
                                    activeColor: ConstantColors.backgroundColor,
                                    checkColor: ConstantColors.secondaryColor,
                                    value: controller.showwhatsApp.value,
                                    onChanged: (value) {
                                      controller.showwhatsApp.value = value!;
                                    }),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Are you using different number for WhatsApp?'
                                    .tr,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff717276),
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: localization == "en"
                                        ? GoogleFonts.roboto().fontFamily
                                        : 'DubaiFont'),
                              )
                            ]),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: controller.terms.value
                                            ? ConstantColors.secondaryColor
                                            : const Color(0xffC8C9CC))),
                                child: Checkbox(
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    focusColor: ConstantColors.secondaryColor,
                                    activeColor: ConstantColors.backgroundColor,
                                    checkColor: ConstantColors.secondaryColor,
                                    value: controller.terms.value,
                                    onChanged: (value) {
                                      controller.terms.value = value!;
                                    }),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'I agree to '.tr,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff717276),
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: localization == "en"
                                        ? GoogleFonts.roboto().fontFamily
                                        : 'DubaiFont'),
                              ),
                              InkWell(
                                onTap: () => {},
                                child: Text(
                                  'Terms & Conditions'.tr,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff717276),
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: localization == "en"
                                          ? GoogleFonts.roboto().fontFamily
                                          : 'DubaiFont'),
                                ),
                              )
                            ]),
                        controller.errorMessage.value != ""
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    textScaleFactor: 1,
                                    controller.errorMessage.value,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: ConstantColors.errorColor,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: FormSubmitButton(
                              disabled: false,
                              label: 'Sign up'.tr,
                              context: context,
                              onPressed: () {
                                // controller.completeSocialSignUp();
                                controller.socialSignUpRequest();
                              }),
                        ),
                      ]))))),
    );
  }
}
