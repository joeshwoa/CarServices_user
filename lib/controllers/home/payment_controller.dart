import 'dart:developer';

import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/models/cartItem.dart';
// import 'package:autoflex/models/item_model.dart';
import 'package:autoflex/services/Home/cartServices.dart';
import 'package:autoflex/services/orders/payment_services.dart';
import 'package:autoflex/shared/components/cart_item.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/cart_screen.dart';
import 'package:autoflex/views/web_view_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'provider_controller.dart';

class PaymentController extends GetxController {
  var loading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<String> paymentByCard() async {
    loading.value = true;
    String url = await PaymentServices.payment();
    //print(url);
    String? state = await Get.to(WebViewScreen(url: url)) ?? "unknown";
    return state;
  }
}
