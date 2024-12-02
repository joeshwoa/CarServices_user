import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmirateController extends GetxController {
   final addEmirateFormKey = GlobalKey<FormState>();
   TextEditingController emirateNameController = TextEditingController();
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
    TextEditingController requistController = TextEditingController();
   checkValidation() {
    final isValid = addEmirateFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }
  addEmirate(){
    if (checkValidation()) {
      Get.back();
    }
  }
}