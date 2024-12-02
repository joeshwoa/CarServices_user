import 'dart:convert';
import 'dart:ui';

import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/signUp.dart';
import '../views/welcome/welcome_screen.dart';

class SharedPreferenceController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    //final storage = new FlutterSecureStorage();

    super.onInit();
  }

  var uuid = ''.obs;
  var userToken = ''.obs;
  var localization = 'en'.obs;
  var language='en'.obs;
  var isLoggedIn = false.obs;
  var welcomed = false.obs;
  Rx<SignUp> userData = SignUp().obs;
  Future<void> setValue(String key, value) async {
    Get.putAsync<SharedPreferences>(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
      return prefs;
    }, tag: 'tagsAreEverywhere', permanent: true);
  }

  Future<void> setValueSecure(String key, value) async {
    await new FlutterSecureStorage().write(key: key, value: value);
  }

  Future<void> setIntValue(String key, value) async {
    Get.putAsync<SharedPreferences>(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, value);
      return prefs;
    }, tag: 'tagsAreEverywhere', permanent: true);
  }

  Future<void> setBoolValue(String key, value) async {
    Get.putAsync<SharedPreferences>(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
      return prefs;
    }, tag: 'tagsAreEverywhere', permanent: true);
  }

  dynamic getValue(value) async {
    return Get.find<SharedPreferences>(tag: 'tagsAreEverywhere').get(value);
    // Get.find works as you'd expect
  }

  dynamic getValueSecure(value) async {
    return FlutterSecureStorage().read(key: value);
    // Get.find works as you'd expect
  }

  Future<void> removeValue() async {
    await Get.find<SharedPreferences>(tag: 'tagsAreEverywhere')
        .remove('userData');
    await Get.find<SharedPreferences>(tag: 'tagsAreEverywhere').remove('token');
  }

  changeLocale(lang) async {
    var response = await Constants.postNetworkService(
        "v1/customer/settings", "withToken", {"iso": lang});
    print(localization.value);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = jsonDecode(response.body);

      if (result != null) {
        toast(message: result["message"]);
      }
    } else {
      toast(message: 'Could Not Change Server Language');
    }
  }
}
