import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
    var isPlaceholderVisible = true.obs;
   TextEditingController phoneController = TextEditingController(text: "+971");
   void initState() {
 isPlaceholderVisible.value = phoneController.text == "+971";

  }
}