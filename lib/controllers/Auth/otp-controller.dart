import 'dart:ffi';

import 'package:autoflex/models/signUp.dart';
import 'package:autoflex/services/Auth/signUpService.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/Auth/success-screen.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  var mobileNumber = '+971 50 123 4567'.obs;
  var otpToken = ''.obs;
  var errorMessage = ''.obs;
  var success = true.obs;
  var otpResendSuccess = false.obs;
  var timerEnd = true.obs;
  var loading = false.obs;
  var endTime = DateTime.now().millisecondsSinceEpoch.obs +
      Duration(seconds: 10).inMilliseconds;

  Future<String?> requestOtp({required String token}) async {
    if (timerEnd.value) {
      try {
        String message = await SignUpService.requestOtp(
          token: token,
        );
        toast(message: message);
        timerEnd.value = false;
        otpResendSuccess.value = true;
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }

  Future<String?> verifyOtp({required String token}) async {
    if (otpToken.value.length == 4 && token.isNotEmpty) {
      try {
        loading.value = true;

        String message =
            await SignUpService.verifyOtp(token: token, otp: otpToken.value);
        toast(message: message);
if(message=='otp is Wrong.' || message.contains('خاطئ')){
  loading.value=false;
}
else{
    loading.value=false;
 Get.offAll(() => SucessScreen(
              type: 'phoneVerified',
            ));
}
       
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }

  Future<String?> editPhone(
      {required String token, required String phone}) async {
    if (phone.isNotEmpty && token.isNotEmpty) {
      try {
        loading.value = true;

        SignUp? editProfileRequest = await SignUpService.editProfile(
            type: 'phone', phone: phone, token: token);

        if (editProfileRequest!.message ==
            'Your Account has been updated successfully.'||editProfileRequest!.message!.contains('بنجاح')) {
          toast(message: editProfileRequest.message.toString());

          mobileNumber.value = phone;

          String message = await SignUpService.requestOtp(
            token: token,
          );
          toast(message: message);
          timerEnd.value = false;
          otpResendSuccess.value = true;
          Get.back();
        }
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }
}
