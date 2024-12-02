import 'package:autoflex/controllers/Auth/social-sign-up-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/Auth/email-sign-up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';
import 'package:sizer/sizer.dart';

import '../../shared/shared_preference.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SocialSignUpController controller = Get.put(SocialSignUpController());
  final SharedPreferenceController sharedPreferenceController =
      Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
  // final SocialSignUpController socialSignUpController = Get.put(SocialSignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ConstantColors.backgroundColor,
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(starsGray)),
              ),
              SvgPicture.asset(logo2),
              const SizedBox(
                height: 63,
              ),
              FormSubmitButton(
                  disabled: false,
                  label: 'Sign up with Email Address'.tr,
                  context: context,
                  onPressed: () {
                    Get.to(EmailSignUnScreen());
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  children: [
                    const Expanded(child: Divider(color: Color(0xffBDBDBD))),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'or continue with Social Signup'.tr,
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  onPressed: () {
                    controller.googleSignUp();
                  },
                  icon: SvgPicture.asset(googleIcon),
                ),
                IconButton(
                  onPressed: () {
                    controller.facebookSignUp();
                  },
                  icon: SvgPicture.asset(facebookIcon),
                ),
              ]),
              const SizedBox(
                height: 50,
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
                    onPressed: () => Get.to(() => SignInScreen()),
                    child: Text('Login'.tr,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
