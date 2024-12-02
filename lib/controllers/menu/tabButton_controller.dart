import 'dart:developer';

import 'package:autoflex/controllers/menu/orders_controller.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabButtonController extends GetxController {
  final ordersController = Get.find<OrdersController>();
  var tab = TabButton(
          index: 0,
          activeColor: ConstantColors.secondaryColor,
          color: ConstantColors.bodyColor2)
      .obs;
  var tabs = <TabButton>[
    TabButton(
        index: 0,
        activeColor: ConstantColors.secondaryColor,
        color: ConstantColors.bodyColor2),
    TabButton(
        index: 1,
        activeColor: ConstantColors.secondaryColor,
        color: ConstantColors.bodyColor2)
  ].obs;

  Future<void> changeTab(int index) async {
    for (var tab in tabs) {
      if (tab.index == index) {
        this.tab.value = tab; // Update the observable tab
        break; // Exit loop once the tab is found and updated
      }
    }
    /* if (index == 0) {
      await ordersController.getOrdersList('pending');
    } else {
      await ordersController.getOrdersList('cancelled');
      inspect('Huh?');
    } */
  }
}

class TabButton {
  int index;
  Color color;
  Color activeColor;

  TabButton(
      {required this.index, required this.color, required this.activeColor});
}
