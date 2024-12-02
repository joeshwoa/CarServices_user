import 'package:autoflex/controllers/Auth/email-sign-up-controller.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:autoflex/views/settings/terms_and_conditions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';
import '../../shared/components/loading.dart';
import '../../styles/icons_assets.dart';

class EmailSignUnScreen extends StatelessWidget {
  EmailSignUnScreen({super.key});
  final EmailSignUpController controller = Get.put(EmailSignUpController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
              backgroundColor: ConstantColors.backgroundColor,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: ConstantColors.backgroundColor,
                leading: Text(''),
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 16.0),
                  child: Text('EMAIL SIGN UP'.tr,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                actions: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.only(end: 16.0, top: 16),
                    child: InkWell(
                        onTap: () => {Get.to(() => HomeScreen())},
                        child: Text(
                          'Skip'.tr,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: ConstantColors.secondaryColor,
                              height: 1.2,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: localization == "en"
                                  ? GoogleFonts.roboto().fontFamily
                                  : 'DubaiFont'),
                        )),
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                          key: controller.signUpFormKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(''),
                                //     Center(
                                //       child: Text('Email Sign Up',
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .titleLarge),
                                //     ),
                                //     InkWell(
                                //         onTap: () => {},
                                //         child: Text(
                                //           'Skip',
                                //           style: TextStyle(
                                //               fontSize: 15,
                                //               fontWeight: FontWeight.w400,
                                //               color: ConstantColors.secondaryColor,
                                //               height: 1.2,
                                //               overflow: TextOverflow.ellipsis,
                                //               fontFamily: localization == "en"
                                //                   ? GoogleFonts.roboto().fontFamily
                                //                   : 'DubaiFont'),
                                //         ))
                                //   ],
                                // ),

                                const SizedBox(
                                  height: 32,
                                ),
                                textField(
                                  hintStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  hint: 'Your Name'.tr,
                                  context: context,
                                  keyboardType: TextInputType.name,
                                  controller: controller.nameController,
                                  isPassword: false,
                                  change: (value) {},
                                  validate: (value) {
                                    return Validations.validateName(
                                        value!, context);
                                  },
                                  disabled: false,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                textField(
                                  hintStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  hint: 'Email Address'.tr,
                                  context: context,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: controller.emailController,
                                  isPassword: false,
                                  change: (value) {},
                                  validate: (value) {
                                    return Validations.validateEmail(
                                        value!, context);
                                  },
                                  disabled: false,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                textField(
                                  hintStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  hint: 'Password'.tr,
                                  context: context,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: controller.passwordController,
                                  isPassword: !controller.visiblePassword.value,
                                  change: (value) {},
                                  validate: (value) {
                                    return Validations.validatePassword(
                                        value!, context);
                                  },
                                  disabled: false,
                                  suffix: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: IconButton(
                                      onPressed: () {
                                        controller.visiblePassword.toggle();
                                      },
                                      icon: controller.visiblePassword.value
                                          ? SvgPicture.asset(
                                              visibility,
                                              width: 20,
                                              height: 20,
                                            )
                                          : SvgPicture.asset(visibilityOff),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                textField(
                                  hintStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  hint: 'Confirm Password'.tr,
                                  context: context,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller:
                                      controller.confirmpasswordController,
                                  isPassword:
                                      !controller.visibleConfirmPassword.value,
                                  change: (value) {},
                                  validate: (value) {
                                    return Validations.validateconfirmPassword(
                                        value!,
                                        context,
                                        controller.passwordController.text);
                                  },
                                  disabled: false,
                                  suffix: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: IconButton(
                                      onPressed: () {
                                        controller.visibleConfirmPassword
                                            .toggle();
                                      },
                                      icon: controller
                                              .visibleConfirmPassword.value
                                          ? SvgPicture.asset(
                                              visibility,
                                              width: 20,
                                              height: 20,
                                            )
                                          : SvgPicture.asset(visibilityOff),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Stack(
                                  children: [
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: SizedBox(
                                        child: textField(
                                          hint: 'Phone Number'.tr,
                                          context: context,
                                          keyboardType: TextInputType.phone,
                                          controller:
                                              controller.phoneController,
                                          isPassword: false,
                                          change: (value) {
                                            controller.isPlaceholderVisible
                                                .value = false;
                                            if (!value.startsWith("+971")) {
                                              controller.phoneController.text =
                                                  "+971";
                                              controller.phoneController
                                                      .selection =
                                                  TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: controller
                                                        .phoneController
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
                                    ),
                                    controller.isPlaceholderVisible.value
                                        ? Positioned(
                                            left: 50,
                                            top: 16,
                                            bottom: 16,
                                            child: IgnorePointer(
                                              ignoring: true,
                                              child: Text(
                                                'Phone number'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
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
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: textField(
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall,
                                                  hint: 'Whats App Number'.tr,
                                                  context: context,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  controller: controller
                                                      .whatsappController,
                                                  isPassword: false,
                                                  change: (value) {
                                                    controller
                                                        .iswhatsAppPlaceholderVisible
                                                        .value = false;
                                                    if (!value
                                                        .startsWith("+971")) {
                                                      controller
                                                          .whatsappController
                                                          .text = "+971";
                                                      controller
                                                              .whatsappController
                                                              .selection =
                                                          TextSelection
                                                              .fromPosition(
                                                        TextPosition(
                                                            offset: controller
                                                                .whatsappController
                                                                .text
                                                                .length),
                                                      );
                                                    }
                                                  },
                                                  validate: (value) {
                                                    return Validations
                                                        .validatePhone(
                                                            value!, context);
                                                  },
                                                  disabled: false,
                                                ),
                                              ),
                                              controller
                                                      .iswhatsAppPlaceholderVisible
                                                      .value
                                                  ? Positioned(
                                                      left: 50,
                                                      top: 16,
                                                      bottom: 16,
                                                      child: IgnorePointer(
                                                        child: Text(
                                                          'Whats App Number'.tr,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall,
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          )
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: controller
                                                        .showwhatsApp.value
                                                    ? ConstantColors
                                                        .secondaryColor
                                                    : Color(0xffC8C9CC))),
                                        child: Checkbox(
                                            side: BorderSide(
                                                color: Colors.transparent),
                                            focusColor:
                                                ConstantColors.secondaryColor,
                                            activeColor:
                                                ConstantColors.backgroundColor,
                                            checkColor:
                                                ConstantColors.secondaryColor,
                                            value:
                                                controller.showwhatsApp.value,
                                            onChanged: (value) {
                                              controller.showwhatsApp.value =
                                                  value!;
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
                                            color: Color(0xff717276),
                                            overflow: TextOverflow.ellipsis,
                                            fontFamily: localization == "en"
                                                ? GoogleFonts.roboto()
                                                    .fontFamily
                                                : 'DubaiFont'),
                                      )
                                    ]),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: controller.terms.value
                                                    ? ConstantColors
                                                        .secondaryColor
                                                    : Color(0xffC8C9CC))),
                                        child: Checkbox(
                                            side: BorderSide(
                                                color: Colors.transparent),
                                            focusColor:
                                                ConstantColors.secondaryColor,
                                            activeColor:
                                                ConstantColors.backgroundColor,
                                            checkColor:
                                                ConstantColors.secondaryColor,
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
                                            color: Color(0xff717276),
                                            overflow: TextOverflow.ellipsis,
                                            fontFamily: localization == "en"
                                                ? GoogleFonts.roboto()
                                                    .fontFamily
                                                : 'DubaiFont'),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            {Get.to(() => TermsScreen())},
                                        child: Text(
                                          'Terms & Conditions'.tr,
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff717276),
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: localization == "en"
                                                  ? GoogleFonts.roboto()
                                                      .fontFamily
                                                  : 'DubaiFont'),
                                        ),
                                      )
                                    ]),

                                controller.errorMessage.value != ""
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 12,
                                          ),
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
                                    : SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0),
                                  child: FormSubmitButton(
                                      disabled: !controller.terms.value,
                                      label: 'Sign up'.tr,
                                      context: context,
                                      onPressed: () {
                                        controller.signUpRequest();
                                      }),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account? '.tr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: localization == "en"
                                            ? GoogleFonts.roboto().fontFamily
                                            : 'DubaiFont',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Get.to(() => SignInScreen()),
                                      child: Text('Login'.tr,
                                          style: TextStyle(
                                            color:
                                                ConstantColors.secondaryColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: localization == "en"
                                                ? GoogleFonts.roboto()
                                                    .fontFamily
                                                : 'DubaiFont',
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                )
                              ]))))),
          controller.loading.value ? const LoadingWidget() : Row()
        ],
      ),
    );
  }
}
