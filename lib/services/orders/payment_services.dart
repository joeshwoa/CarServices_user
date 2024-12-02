import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/orders.dart';
import 'package:autoflex/shared/constants.dart';
import 'package:get/get.dart';

class PaymentServices {
  static Future<String> payment() async {
    var response = await Constants.getNetworkService(
        "v1/customer/payments", "withToken");

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      return json.decode(response.body)['payment_link'];
    }

    return response.body;
  }
}
