import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/views/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/signUp.dart';
import '../../services/Auth/signUpService.dart';
import '../../shared/components/toast.dart';
import '../../shared/constants.dart';
import '../../shared/shared_preference.dart';
import '../../styles/colors.dart';

class LogoutController extends GetxController {
  var pref = Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
  var loading = false.obs;

  Future<String?> logoutRequest() async {
    loading.value = true;
    var logoutRequest = await SignUpService.signout();
    dynamic isLoggedIn = false;
    dynamic token = "";
    SignUp userData = SignUp();
    pref.userToken.value = token;
    pref.isLoggedIn.value = isLoggedIn;
    pref.userData.value = userData;
    loading.value = false;
    return logoutRequest['message'];
  }
}
