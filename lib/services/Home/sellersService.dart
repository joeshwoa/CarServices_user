import 'package:autoflex/models/sellerProduct.dart';
import 'package:autoflex/models/wishlistItem.dart';
import 'package:autoflex/styles/icons_assets.dart';

import '../../models/sellers.dart';
import '../../shared/constants.dart';

class SellersService {
  static Future<Sellers?> getSellers(categoryId, cityId,slotId,day,date,carTypeId, searchKeyword) async {
    var response = await Constants.getNetworkService(
        "v1/customer/sellers?category_id=$categoryId&slot_id=$slotId&day=$day&date=$date&car_type_id=$carTypeId&search=$searchKeyword",
        "withToken");
    print(categoryId);
    print(cityId);
    print(slotId);
    print(day);
    print(date);
    print(carTypeId);
    print(searchKeyword);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = sellersFromJson(response.body);
      print(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<SellerProduct?> getProductDetails(productId) async {
    var response = await Constants.getNetworkService(
        "v1/sellers/product/$productId", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = sellerProductFromJson(response.body);
      print(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<WishlistItem?> favouriteSeller(sellerId) async {
    var response = await Constants.postNetworkService(
        "v1/customer/wishlist/$sellerId", "withToken", {});
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = wishlistItemFromJson(response.body);

      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }
}
