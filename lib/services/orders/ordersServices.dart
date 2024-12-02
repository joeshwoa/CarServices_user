import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/invoice.dart';
import 'package:autoflex/models/orders.dart';
import 'package:autoflex/shared/constants.dart';
import 'package:get/get.dart';

class OrdersServices {
  static Future<Orders?> getOrders(status) async {
    var response = await Constants.getNetworkService(
        "v1/customer/orders/items/all?status=$status", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = ordersFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<Invoice?> getInvoiceData(orderID) async {
    var response = await Constants.getNetworkService(
        "v1/customer/invoices/$orderID", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = invoiceFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> cancelOrder({required String orderId}) async {
    var response = await Constants.postNetworkService(
        "v1/customer/orders/$orderId/cancel", "withToken", {});

    var result = jsonDecode(response.body);
    if (result != null) {
      return result;
    } else
      return null;
  }
}
