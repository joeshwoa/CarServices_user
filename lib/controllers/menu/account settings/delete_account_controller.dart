import 'package:autoflex/views/settings/deleted_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  final deleteAccountFormKey = GlobalKey<FormState>();
  var isPlaceholderVisible = true.obs;
  TextEditingController phoneController = TextEditingController(text: "+971");

  @override
  void onInit() {
    super.onInit();
    isPlaceholderVisible.value = phoneController.text == "+971";
  }

  checkValidation() {
    final isValid = deleteAccountFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  Future<String?> deleteAccountRequest() async {
    if (checkValidation()) {
      Get.to(() => const DeletedScreen());
      try {} catch (e) {
        print(e);
      }
    }
    return null;
  }
}
