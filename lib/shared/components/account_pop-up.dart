import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/controllers/home/homeController.dart';
import 'package:autoflex/controllers/home/locationController.dart';
import 'package:autoflex/controllers/menu/orders_controller.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/Auth/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPopUp extends StatelessWidget {
  const AccountPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Sign in Required'.tr),
      content: Text('Sign in required to book any service'.tr),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Sign in'.tr),
          onPressed: () {
            Get.delete<HomeController>(force: true);
            Get.delete<CarController>(force: true);
            Get.delete<LocationController>(force: true);
            Get.delete<CartController>(force: true);
            Get.delete<OrdersController>(force: true);
            Get.offAll(() => SignInScreen());
          },
        ),
        CupertinoDialogAction(
          child: Text(
            'Sign up'.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Get.delete<HomeController>(force: true);
            Get.delete<CarController>(force: true);
            Get.delete<LocationController>(force: true);
            Get.delete<CartController>(force: true);
            Get.delete<OrdersController>(force: true);
            Get.offAll(() => SignUpScreen());
          },
        ),
      ],
    );
  }
}
