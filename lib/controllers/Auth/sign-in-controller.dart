import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/main.dart';
import 'package:autoflex/views/Auth/otp-screen.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:restart_app/restart_app.dart';

import '../../models/signUp.dart';
import '../../services/Auth/signUpService.dart';
import '../../shared/components/toast.dart';
import '../../shared/constants.dart';
import '../../shared/shared_preference.dart';
import '../../styles/colors.dart';

class SignInController extends GetxController {
  final SharedPreferenceController sharedPreferenceController =
      Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
  final signInFormKey = GlobalKey<FormState>();
  // GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  var type = "password".tr.obs;
  var visiblePassword = false.obs;
  var loading = false.obs;
  var errorMessage = "".obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  checkValidation() {
    final isValid = signInFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  Future<String?> loginRequest() async {
    print(
        "login lang ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').localization.value}");

    if (checkValidation()) {
      try {
        loading.value = true;

        SignUp? signInRequest = await SignUpService.sigIn(
          email: emailController.text,
          password: passwordController.text,
        );
        // return '';
        if ((signInRequest!.message == 'Logged in successfully.' &&
                    signInRequest.data!.isVerified! ||
                signInRequest!.message!.contains('بنجاح')) &&
            signInRequest.data!.isVerified!) {
          errorMessage.value = "";

          toast(message: signInRequest.message.toString());

          await sharedPreferenceController.setValue(
              'userData', signUpToJson(signInRequest));
          sharedPreferenceController.update();

          sharedPreferenceController.userToken.value =
              signInRequest.token.toString();
          sharedPreferenceController.userToken.refresh();
          Constants.headersWithToken.update(
              'Authorization',
              (value) =>
                  'Bearer ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').userToken.value}');

          sharedPreferenceController.isLoggedIn.value = true;
          sharedPreferenceController.welcomed.value = true;
          sharedPreferenceController.isLoggedIn.refresh();
          sharedPreferenceController.userData.value = signInRequest;
          sharedPreferenceController.userData.refresh();
          await sharedPreferenceController.setBoolValue("isLoggedIn", true);
          await sharedPreferenceController.setBoolValue("welcomed", true);
          await sharedPreferenceController.setValue(
              "token", signInRequest.token);
          inspect(signInRequest.token);
          print(
              "login loca ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').localization.value}");
          //  await sharedPreferenceController.setValue(
          // "userData", signUpToJson(signInRequest));
          sharedPreferenceController.update();
          await sharedPreferenceController.changeLocale(
              Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
                  .localization
                  .value);

          Future.delayed(const Duration(seconds: 2), () {
            Get.offAll(() => HomeScreen());
            loading.value = false;
            emailController.text = '';
            passwordController.text = '';
          });

          return "registered successfully";
        } else if (signInRequest.message == 'Logged in successfully.' &&
                !signInRequest.data!.isVerified! ||
            signInRequest!.message!.contains('بنجاح') &&
                !signInRequest.data!.isVerified!) {
          emailController.text = '';
          passwordController.text = '';
          Get.to(OtpScreen(
            token: signInRequest.token ?? '',
            phone: signInRequest.data!.phone ?? '',
          ));
          loading.value = false;
        } else {
          errorMessage.value = signInRequest.message!.split('.')[0];
          loading.value = false;
          return signInRequest.message;
        }
        // }
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }
}
