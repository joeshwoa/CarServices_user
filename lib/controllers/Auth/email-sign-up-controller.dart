import 'package:autoflex/views/Auth/otp-screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/signUp.dart';
import '../../services/Auth/signUpService.dart';
import '../../shared/components/toast.dart';

class EmailSignUpController extends GetxController {
  final signUpFormKey = GlobalKey<FormState>();
  // GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  var type = "password".tr.obs;
  var visiblePassword = false.obs;
  var visibleConfirmPassword = false.obs;
  var showwhatsApp = false.obs;
  var terms = false.obs;
  var loading = false.obs;
  var errorMessage = "".obs;
  var isPlaceholderVisible = true.obs;
  var iswhatsAppPlaceholderVisible = true.obs;
  AccessToken? _accessToken;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController(text: "+971");
  TextEditingController whatsappController =
      TextEditingController(text: "+971");

  @override
  void initState() {
    isPlaceholderVisible.value = phoneController.text == "+971";
    iswhatsAppPlaceholderVisible.value = whatsappController.text == "+971";
  }

  checkValidation() {
    final isValid = signUpFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  Future<String?> signUpRequest() async {
    if (checkValidation()) {
      try {
        loading.value = true;

        SignUp? signUpRequest = await SignUpService.signUp(
            name: nameController.text,
            // lastName: nameController.text.split(' ')[1].toString(),
            email: emailController.text,
            password: passwordController.text,
            password_confirmation: confirmpasswordController.text,
            phone: phoneController.text,
            whatsapp: whatsappController.text);
        // return '';
        if (signUpRequest!.message ==
                'Your Account has been created successfully.' ||
            signUpRequest!.message!.contains('بنجاح')) {
          loading.value = false;
          errorMessage.value = "";
          toast(message: signUpRequest.message.toString());
          Get.offAll(() => OtpScreen(
                token: signUpRequest.token ?? '',
                phone: phoneController.text,
              ));
          return "registered successfully";
        } else {
          errorMessage.value = signUpRequest.message!.split('.')[0];
          loading.value = false;
          return signUpRequest.message;
        }
        // }
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }
}
