
import 'dart:developer';

import 'package:autoflex/models/categories.dart';
import 'package:autoflex/models/notifications.dart';
import 'package:autoflex/services/Home/categoriesService.dart';
import 'package:autoflex/services/Home/home_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var categories=<Datum>[].obs;
  var loading=false.obs;
  var message = RemoteMessage().obs;
  var showNotification = false.obs;
  Notifications? getNotificationsRequest = Notifications(data: []);
  Rx<bool> unseenMessages = false.obs;
    @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCategoriesRequest();
    await getNotifications();
    }
     Future<Categories?> getCategoriesRequest() async {
    try {
      loading.value = true;
      Categories? getCategoriesRequest = await CategoriesService.getCategories();
      categories.value=getCategoriesRequest!.data!;
      inspect(categories);
      loading.value = false;

    
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<void> getNotifications() async {
    loading.value = true;

    getNotificationsRequest = await HomeServices.getNotifications();
    unseenMessages.value = (getNotificationsRequest!.totalUnseen! > 0);
    // Create a DateFormat object for the desired format

    loading.value = false;
  }
  Future<void> readAllNotifications() async {
    bool done = await HomeServices.readAllNotifications();
    if(done) {
      getNotificationsRequest!.totalUnseen = 0;
      unseenMessages.value = false;
    }
  }

}