import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:autoflex/firebase_api.dart';
import 'package:autoflex/shared/constants.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

final SharedPreferenceController sharedPreferenceController =
    Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');

class AuthService {
  static Future<String> refreshNotToken() async {
    var response = await Constants.postNetworkService(
        "v1/customer/token/refresh", "withToken", {
      "fcm_token": FirebaseApi.token
    });

    return json.decode(response.body)['message'];
  }
}
