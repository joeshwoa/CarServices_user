import 'dart:math';

import 'package:autoflex/models/signUp.dart';
import 'package:autoflex/services/Auth/signUpService.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/shared_preference.dart';

class PersonalDataController extends GetxController {
  final SharedPreferenceController sharedPreferenceController =
      Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  var selectedGender = ''.obs;
  var selectedGenderISO = {"ذكر": "Male", "أنثى": "Female"};
  var selectedDOB = ''.obs;
  Rx<XFile?> image = XFile("").obs;
  var imageUploaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.text =
        sharedPreferenceController.userData.value.data!.fullName ??
            sharedPreferenceController.userData.value.data!.firstName ??
            'first name' +
                ' ' +
                sharedPreferenceController.userData.value.data!.lastName ??
            'last name';
    phoneController.text =
        sharedPreferenceController.userData.value.data!.phone!;
    whatsappController.text =
        sharedPreferenceController.userData.value.data!.whatsappNumber != null
            ? sharedPreferenceController.userData.value.data!.whatsappNumber!
            : '+971';
  }

  changePhotoRequest(type) async {
    try {
      if (type == 'gallery') {
        image.value = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 1800,
          maxHeight: 1800,
        );
      } else {
        image.value = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
      }
      imageUploaded.value = true;
      SignUp? editProfileRequest =
          await SignUpService.editProfile(image: image()!.path!, type: 'image');
      print(editProfileRequest!.message);
      if (editProfileRequest.message ==
              'Your Account has been updated successfully.' ||
          editProfileRequest!.message!.contains('بنجاح')) {
        // Get.back();
        toast(message: editProfileRequest.message.toString());
        sharedPreferenceController.userData.value = editProfileRequest;
        sharedPreferenceController.userData.refresh();
        await sharedPreferenceController.setValue(
            'userData', signUpToJson(editProfileRequest));
        sharedPreferenceController.update();
      }

      if (kDebugMode) {
        print(image.value?.name);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  editProfile(type) async {
    switch (type) {
      case 'name':
        SignUp? editProfileRequest = await SignUpService.editProfile(
            name: nameController.text, type: 'name');
        print(editProfileRequest!.message);
        if (editProfileRequest.message ==
                'Your Account has been updated successfully.' ||
            editProfileRequest!.message!.contains('بنجاح')) {
          Get.back();
          toast(message: editProfileRequest.message.toString());
          sharedPreferenceController.userData.value = editProfileRequest;
          sharedPreferenceController.userData.refresh();
          await sharedPreferenceController.setValue(
              'userData', signUpToJson(editProfileRequest));
          sharedPreferenceController.update();
        }
        print(sharedPreferenceController.userData.value.data!.fullName);
        break;
      case 'phone':
        SignUp? editProfileRequest = await SignUpService.editProfile(
            phone: phoneController.text, type: 'phone');
        print(editProfileRequest!.message);
        if (editProfileRequest.message ==
                'Your Account has been updated successfully.' ||
            editProfileRequest!.message!.contains('بنجاح')) {
          Get.back();
          toast(message: editProfileRequest.message.toString());
          sharedPreferenceController.userData.value = editProfileRequest;
          sharedPreferenceController.userData.refresh();
          await sharedPreferenceController.setValue(
              'userData', signUpToJson(editProfileRequest));
          sharedPreferenceController.update();
        }
        break;
      case 'whatsapp':
        SignUp? editProfileRequest = await SignUpService.editProfile(
            whatsapp: whatsappController.text, type: type);
        print(editProfileRequest!.message);
        if (editProfileRequest.message ==
                'Your Account has been updated successfully.' ||
            editProfileRequest!.message!.contains('بنجاح')) {
          Get.back();
          toast(message: editProfileRequest.message.toString());
          sharedPreferenceController.userData.value = editProfileRequest;
          sharedPreferenceController.userData.refresh();
          await sharedPreferenceController.setValue(
              'userData', signUpToJson(editProfileRequest));
          sharedPreferenceController.update();
        }
        else{
           toast(message: editProfileRequest.message.toString());
        }
        break;
      case 'gender':
        var gender = Get.locale!.languageCode == 'en'
            ? selectedGender.value
            : selectedGenderISO[selectedGender.value];
        SignUp? editProfileRequest =
            await SignUpService.editProfile(gender: gender, type: type);
        print(editProfileRequest!.message);
        if (editProfileRequest.message ==
                'Your Account has been updated successfully.' ||
            editProfileRequest!.message!.contains('بنجاح')) {
          Get.back();
          toast(message: editProfileRequest.message.toString());
          sharedPreferenceController.userData.value = editProfileRequest;
          sharedPreferenceController.userData.refresh();
          await sharedPreferenceController.setValue(
              'userData', signUpToJson(editProfileRequest));
          sharedPreferenceController.update();
        }
        break;
      case 'dob':
        SignUp? editProfileRequest = await SignUpService.editProfile(
            dateOfBirth: selectedDOB.value, type: type);
        print(editProfileRequest!.message);
        if (editProfileRequest.message ==
                'Your Account has been updated successfully.' ||
            editProfileRequest!.message!.contains('بنجاح')) {
          Get.back();
          toast(message: editProfileRequest.message.toString());
          sharedPreferenceController.userData.value = editProfileRequest;
          sharedPreferenceController.userData.refresh();
          await sharedPreferenceController.setValue(
              'userData', signUpToJson(editProfileRequest));
          sharedPreferenceController.update();
        }
        break;
    }
  }
}
