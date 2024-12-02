import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/notifications.dart';
import 'package:autoflex/shared/constants.dart';
import 'package:flutter/foundation.dart';

class HomeServices {
  static Future<Notifications?> getNotifications() async {
    var response =
    await Constants.getNetworkService("v1/customer/notifications", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = notificationsFromJson(response.body);
      return result;
    } else {
      if(kDebugMode) {
        print(response.body);
      }
      return null;
    }
  }
  static Future<bool> readAllNotifications() async {
    var response =
    await Constants.putNetworkService("v1/customer/notifications/read/all", "withToken", {});
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      if(kDebugMode) {
        print(response.body);
      }
      return false;
    }
  }
}
