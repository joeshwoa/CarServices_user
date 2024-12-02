import 'dart:developer';

import 'package:autoflex/models/categoryAvailability.dart';
import 'package:autoflex/models/sellers.dart';
import 'package:autoflex/services/Home/categoriesService.dart';
import 'package:autoflex/services/Home/sellersService.dart';
import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsController extends GetxController with SingleGetTickerProviderMixin {
  var sellers = <Datum>[].obs;
  var loading=false.obs;
  var times=<Data>[].obs;
  var dates=[].obs;
    var weekdays=[].obs;
var datesWidget=<Widget>[].obs;
var timeSlots=<Widget>[].obs;
var today = DateTime.now().obs;
var selectedDate=''.obs;
var weekday=''.obs;
var monthDay=0.obs;
var date=DateTime.now().add(Duration(days: 0)).obs;
late TabController tabController;
  var isInitialized = false.obs;
var slots = [
    {"id": 1, "from": "12 AM", "to": "1 AM"},
    {"id": 2, "from": "1 AM", "to": "2 AM"},
    {"id": 3, "from": "2 AM", "to": "3 AM"},
    {"id": 4, "from": "3 AM", "to": "4 AM"},
    {"id": 5, "from": "4 AM", "to": "5 AM"},
    {"id": 6, "from": "5 AM", "to": "6 AM"},
    {"id": 7, "from": "6 AM", "to": "7 AM"},
    {"id": 8, "from": "7 AM", "to": "8 AM"},
    {"id": 9, "from": "8 AM", "to": "9 AM"},
    {"id": 10, "from": "9 AM", "to": "10 AM"},
    {"id": 11, "from": "10 AM", "to": "11 AM"},
    {"id": 12, "from": "11 AM", "to": "12 PM"},
    {"id": 13, "from": "12 PM", "to": "1 PM"},
    {"id": 14, "from": "1 PM", "to": "2 PM"},
    {"id": 15, "from": "2 PM", "to": "3 PM"},
    {"id": 16, "from": "3 PM", "to": "4 PM"},
    {"id": 17, "from": "4 PM", "to": "5 PM"},
    {"id": 18, "from": "5 PM", "to": "6 PM"},
    {"id": 19, "from": "6 PM", "to": "7 PM"},
    {"id": 20, "from": "7 PM", "to": "8 PM"},
    {"id": 21, "from": "8 PM", "to": "9 PM"},
    {"id": 22, "from": "9 PM", "to": "10 PM"},
    {"id": 23, "from": "10 PM", "to": "11 PM"},
    {"id": 24, "from": "11 PM", "to": "12 AM"}
  ];
  

  @override
  void onInit() async{
   
    super.onInit();
    // getSellersRequest("");
        for (var i = 0; i <= 4; i++) {
       date.value = today.value.add(Duration(days: i));
       weekday.value = DateFormat('EE').format(date.value);
   monthDay.value = date.value.day;
dates.value.add(date.value.toString().split(' ')[0]);
weekdays.value.add(weekday.value);}
  // date.value = today.value.add(Duration(days: 0));
       weekday.value = DateFormat('EE').format(date.value);
       monthDay.value = date.value.day;
  
    await getCategoryAvailibiltyRequest(dates.value[0],weekdays[0].toUpperCase());
      initializeTabController();
      inspect(carController.cars.value);
     selectedDate.value=today.value.toString().split(' ')[0];
         
  }
  void initializeTabController() {
    tabController = TabController(length: dates.length, vsync: this);
    tabController.addListener(_handleTabChange);
    isInitialized.value = true;
  }
   void _handleTabChange() {
    if (!tabController.indexIsChanging) {
      int index = tabController.index;
      _onTabChanged(index);
    }
  }

  void _onTabChanged(int index) {
    print('hello');
    getCategoryAvailibiltyRequest(dates[index], weekdays[index]);
    selectedDate.value=dates[index].toString();
  }
// Future<Sellers?> getSellersRequest(keyword) async {
//     try {
//       loading.value = true;
//       Sellers? getSellersRequest = await SellersService.getSellers(Get.arguments['categoryId'],Get.arguments['cityId'],keyword);
//       sellers.value=getSellersRequest!.data!;
//       loading.value = false;

    
//     } catch (e) {
//       loading.value = false;
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//     return null;
//   }
Future<CategoryAvailability?> getCategoryAvailibiltyRequest(date,weekday) async {
    try {
      loading.value = true;
      CategoryAvailability? getCategoryAvailibiltyRequest = await CategoriesService.getCategoryAvailability(date,weekday,Get.arguments['categoryId'],Get.arguments['carTypeId']);
      times.value=getCategoryAvailibiltyRequest!.data!;
print("typeid "+ Get.arguments['carTypeId'].toString());
inspect(times.value);
      loading.value = false;

    
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

}