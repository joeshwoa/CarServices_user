import 'package:autoflex/models/categoryAvailability.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../models/categories.dart';
import '../../shared/constants.dart';

class CategoriesService {
  static Future<Categories?>getCategories() async {
    var response = await Constants.getNetworkService(
        "v1/categories", "withToken");
        print(response.body);
           if (response.statusCode == 200 || response.statusCode == 201) {
      var result = categoriesFromJson(response.body);
     
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }
  static Future<CategoryAvailability?>getCategoryAvailability(date,day,categoryId,carTypeId) async {
    var response = await Constants.getNetworkService(
        "v1/products/availability/all?date=$date&day=$day&category_id=$categoryId&car_type_id=$carTypeId", "withToken");
           if (response.statusCode == 200 || response.statusCode == 201) {
      var result = categoryAvailabilityFromJson(response.body);
     print(carTypeId);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }
  
  }