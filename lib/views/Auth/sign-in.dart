import 'package:autoflex/controllers/Auth/email-sign-up-controller.dart';
import 'package:autoflex/controllers/Auth/sign-in-controller.dart';
import 'package:autoflex/controllers/Auth/social-sign-up-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/Auth/forget-password.dart';
import 'package:autoflex/views/Auth/signUp.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';

import '../../shared/components/loading.dart';
import '../../shared/shared_preference.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final SignInController controller = Get.put(SignInController());
  final EmailSignUpController emailSignUpController =
      Get.put(EmailSignUpController());
  final SocialSignUpController socialSignUpController =
      Get.put(SocialSignUpController());
  final SharedPreferenceController sharedPreferenceController =
      Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
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
                leading: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(start: 16.0, top: 16.0),
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
                  ),
              
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: () async {
                        if (sharedPreferenceController.localization.value == 'en') {
                          Get.updateLocale(Locale('ar'));
                          sharedPreferenceController.localization.value = 'ar';
                          await sharedPreferenceController.setValue(
                              'localization', 'ar');
                        } else {
                          Get.updateLocale(Locale('en'));
                          sharedPreferenceController.localization.value = 'en';
                          await sharedPreferenceController.setValue(
                              'localization', 'en');
                        }
                        await sharedPreferenceController.changeLocale( sharedPreferenceController.localization.value);
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
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                        key: controller.signInFormKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 64.0),
                                  child: SvgPicture.asset(logo2),
                                ),
                              ),
                              Center(
                                child: Text('SIGN IN'.tr,
                                    style: Theme.of(context).textTheme.titleLarge),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              textField(
                                hintStyle: Theme.of(context).textTheme.displaySmall,
                                hint: 'Email Address'.tr,
                                context: context,
                                keyboardType: TextInputType.emailAddress,
                                controller: controller.emailController,
                                isPassword: false,
                                change: (value) {},
                                validate: (value) {
                                  return Validations.validateEmail(value!, context);
                                },
                                disabled: false,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              textField(
                                hintStyle: Theme.of(context).textTheme.displaySmall,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
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
                              controller.errorMessage.value != ""
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          overflow: TextOverflow.visible,
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
                              Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                      onPressed: () {
                                        Get.to(() => ForgetPasswordScreen());
                                      },
                                      child: Text(
                                        'Forget Password?'.tr,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: ConstantColors.primaryColor,
                                            fontFamily: localization == "en"
                                                ? GoogleFonts.roboto().fontFamily
                                                : 'DubaiFont'),
                                      ))),
                              FormSubmitButton(
                                  disabled: false,
                                  label: 'Login'.tr,
                                  context: context,
                                  onPressed: () {
                                    controller.loginRequest();
                                  }),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        child: Divider(color: Color(0xffBDBDBD))),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          'or continue with Social Login'.tr,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: localization == "en"
                                                ? GoogleFonts.roboto().fontFamily
                                                : 'DubaiFont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                        child: Divider(
                                      color: Color(0xffBDBDBD),
                                    ))
                                  ],
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        socialSignUpController
                                            .socialProvider.value = 'Google';
                                        socialSignUpController.socialLogin();
                                      },
                                      icon: SvgPicture.asset(googleIcon),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        socialSignUpController
                                            .socialProvider.value = 'facebook';
                                        socialSignUpController.socialLogin();
                                      },
                                      icon: SvgPicture.asset(facebookIcon),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 44,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don’t have an account? '.tr,
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
                                    onPressed: () => Get.to(() => SignUpScreen()),
                                    child: Text('Sign Up'.tr,
                                        style: TextStyle(
                                          color: ConstantColors.secondaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: localization == "en"
                                              ? GoogleFonts.roboto().fontFamily
                                              : 'DubaiFont',
                                        )),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              )
                            ]),
                      )))),
           controller.loading.value ? const LoadingWidget() : Row()
        ],
      ),
    );
  }
}
