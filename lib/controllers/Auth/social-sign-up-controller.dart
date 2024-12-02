import 'dart:developer';

import 'package:autoflex/services/Auth/signUpService.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/constants.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:autoflex/views/Auth/otp-screen.dart';
import 'package:autoflex/views/Auth/social-sign-up.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/signUp.dart';

class SocialSignUpController extends GetxController {
  final socialSignUpFormKey = GlobalKey<FormState>();
  // GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  var loading = false.obs;
  var errorMessage = "".obs;
  var isPlaceholderVisible = true.obs;
  var iswhatsAppPlaceholderVisible = true.obs;
  var showwhatsApp = false.obs;
  var terms = false.obs;
  AccessToken? _accessToken;
  var socialProvider=''.obs;
  var userData={};
  Map tempSignUntilUserAddPhone = {};
  final List<String> scopes = <String>[
    'email',
    /*'profile',
   'openid',
   'https://www.googleapis.com/auth/user.phonenumbers.read',*/
  ];
  TextEditingController phoneController = TextEditingController(text: "+971");
  TextEditingController whatsappController = TextEditingController(text: "+971");
  void initState() {
    isPlaceholderVisible.value = phoneController.text == "+971";
    iswhatsAppPlaceholderVisible.value = whatsappController.text == "+971";
  }
  checkValidation() {
    final isValid = socialSignUpFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }
  facebookSignUp() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
    );

    if (result.status == LoginStatus.success) {
      userData = await FacebookAuth.instance.getUserData();
      _accessToken = result.accessToken!;
      //print(_accessToken!.tokenString.toString());
      socialProvider.value='facebook';
      Get.to(SocialSignUpScreen());
    }
  }


  Future<String?> socialSignUpRequest() async {
    if (checkValidation()) {
      if(userData!={}&& socialProvider=='facebook'){
        try {
          loading.value = true;
          SignUp? signInRequest = await SignUpService.signSocial(
              name: userData['name'],
              phone: phoneController.text,
              email: userData['email'],
              provider: 'Facebook',
              provider_id: userData['id'],
              provider_token: _accessToken!.tokenString
          );
          if(!signInRequest!.data!.isVerified!){
            Get.offAll(() => OtpScreen(token: signInRequest.token??'', phone: phoneController.text,));

          }
          else{
            toast(message: signInRequest.message!.tr);

            await sharedPreferenceController.setValue(
                'userData', signUpToJson(signInRequest));
            sharedPreferenceController.update();

            sharedPreferenceController.userToken.value =
                signInRequest.token.toString();
            sharedPreferenceController.userToken.refresh();
            Constants.headersWithToken.update(
                'Authorization',
                    (value) =>
                'Bearer ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').userToken.value}');

            sharedPreferenceController.isLoggedIn.value = true;
            sharedPreferenceController.welcomed.value = true;
            sharedPreferenceController.isLoggedIn.refresh();
            sharedPreferenceController.userData.value = signInRequest;
            sharedPreferenceController.userData.refresh();
            await sharedPreferenceController.setBoolValue("isLoggedIn", true);
            await sharedPreferenceController.setBoolValue("welcomed", true);
            await sharedPreferenceController.setValue(
                "token", signInRequest.token);
            inspect(signInRequest.token);

            //  await sharedPreferenceController.setValue(
            // "userData", signUpToJson(signInRequest));
            sharedPreferenceController.update();
// await sharedPreferenceController.changeLocale();
            Future.delayed(const Duration(seconds: 2), () {
              Get.offAll(() => HomeScreen());});
            Get.offAll(() =>HomeScreen());
          }

        }
        catch(e){/*print(e);*/}
      }else{
        completeSocialSignUp();
      }
    }
    return null;}
  socialLogin() async {

    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    GoogleSignInAccount? googleData;
    try {
      errorMessage.value = '';
      loading.value = true;
      SignUp? signInRequest;
      if(socialProvider.value=='Google'){
        await _googleSignIn.signOut();
        googleData = await _googleSignIn.signIn();
        final GoogleSignInAuthentication? googleAuth =
        await googleData?.authentication;

        // Create a new credential

        if (kDebugMode) {
          print(googleData);
          print('auth');
          print(googleAuth?.accessToken);
        }
        signInRequest = await SignUpService.signSocial(
            name: googleData!.displayName??'',
            // lastName: nameController.text.split(' ')[1].toString(),
            email: googleData.email,
            provider: 'Google',
            provider_id: googleData.id,
            provider_token: googleAuth!.accessToken??''
        );
      }else{
        final LoginResult result = await FacebookAuth.instance.login(
          permissions: ['email', 'public_profile'],
        );

        if (result.status == LoginStatus.success) {
          userData = await FacebookAuth.instance.getUserData();
          _accessToken = result.accessToken!;
          //print(_accessToken!.tokenString.toString());
          socialProvider.value='facebook';
          signInRequest = await SignUpService.signSocial(
              name: userData['name'],
              // lastName: nameController.text.split(' ')[1].toString(),
              email: userData['email'],
              provider: 'Facebook',
              provider_id: userData['id'],
              provider_token: _accessToken!.tokenString
          );
        }
      }



      if(signInRequest!.message == 'Logged in successfully.'.tr && !signInRequest.data!.isVerified!) {

        loading.value = false;
        errorMessage.value = "";
        toast(message: signInRequest.message.toString());
        Get.offAll(() => OtpScreen(token: signInRequest!.token??'', phone: phoneController.text,));
      } else if (signInRequest.message == 'Logged in successfully.'.tr && signInRequest.data!.isVerified!) {
        toast(message: signInRequest.message!.tr);

        await sharedPreferenceController.setValue(
            'userData', signUpToJson(signInRequest));
        sharedPreferenceController.update();

        sharedPreferenceController.userToken.value =
            signInRequest.token.toString();
        sharedPreferenceController.userToken.refresh();
        Constants.headersWithToken.update(
            'Authorization',
                (value) =>
            'Bearer ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').userToken.value}');

        sharedPreferenceController.isLoggedIn.value = true;
        sharedPreferenceController.welcomed.value = true;
        sharedPreferenceController.isLoggedIn.refresh();
        sharedPreferenceController.userData.value = signInRequest;
        sharedPreferenceController.userData.refresh();
        await sharedPreferenceController.setBoolValue("isLoggedIn", true);
        await sharedPreferenceController.setBoolValue("welcomed", true);
        await sharedPreferenceController.setValue(
            "token", signInRequest.token);
        inspect(signInRequest.token);

        //  await sharedPreferenceController.setValue(
        // "userData", signUpToJson(signInRequest));
        sharedPreferenceController.update();

        Future.delayed(const Duration(seconds: 2), () {
          Get.offAll(() => HomeScreen());
        });
      }


    } catch (e) {
      loading.value = false;
      if (kDebugMode) {

        print(e);
      }
      toast(message: e.toString());
    }
  }

  googleSignUp() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    GoogleSignInAccount? googleData;
    try {
      errorMessage.value = '';
      loading.value = true;
      await _googleSignIn.signOut();
      googleData = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleData?.authentication;
      socialProvider.value='Google';
      // Create a new credential

      if (kDebugMode) {
        print(googleData);
        print('auth');
        print(googleAuth?.accessToken);
      }
      //toast(message: 'email : ${googleData!.email}');
      //toast(message: 'name : ${googleData!.displayName}');
      /*String phone = await getPhoneNumber(googleAuth!.accessToken??'');
     print (phone);*/

      /*if(phone.isNotEmpty) {
       SignUp? signInRequest = await SignUpService.signSocial(
           name: googleData!.displayName??'',
           // lastName: nameController.text.split(' ')[1].toString(),
           email: googleData.email,
           phone: phone,
           provider: 'Google',
           provider_id: googleData.id,
           provider_token: googleAuth.accessToken??''
       );

       if(signInRequest!.message == 'Logged in successfully.'.tr) {
         toast(message: signInRequest!.message!.tr);

         await sharedPreferenceController.setValue(
             'userData', signUpToJson(signInRequest));
         sharedPreferenceController.update();

         sharedPreferenceController.userToken.value =
             signInRequest.token.toString();
         sharedPreferenceController.userToken.refresh();
         Constants.headersWithToken.update(
             'Authorization',
                 (value) =>
             'Bearer ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').userToken.value}');

         sharedPreferenceController.isLoggedIn.value = true;
         sharedPreferenceController.welcomed.value = true;
         sharedPreferenceController.isLoggedIn.refresh();
         sharedPreferenceController.userData.value = signInRequest;
         sharedPreferenceController.userData.refresh();
         await sharedPreferenceController.setBoolValue("isLoggedIn", true);
         await sharedPreferenceController.setBoolValue("welcomed", true);
         await sharedPreferenceController.setValue(
             "token", signInRequest.token);
         inspect(signInRequest.token);

         //  await sharedPreferenceController.setValue(
         // "userData", signUpToJson(signInRequest));
         sharedPreferenceController.update();

         Future.delayed(const Duration(seconds: 2), () {
           Get.offAll(() => HomeScreen());
         });
       }
     } else {
       tempSignUntilUserAddPhone = {
         'name': googleData!.displayName??'',
         'email': googleData.email,
         'provider': 'Google',
         'provider_id': googleData.id,
         'provider_token': googleAuth!.accessToken??''
       };
       Get.offAll(() => SocialSignUpScreen());
     }*/

      tempSignUntilUserAddPhone = {
        'name': googleData!.displayName??'',
        'email': googleData.email,
        'provider': 'Google',
        'provider_id': googleData.id,
        'provider_token': googleAuth!.accessToken??''
      };
      Get.offAll(() => SocialSignUpScreen());


    } catch (e) {
      if (kDebugMode) {
        loading.value = false;
        print(e);
      }
      toast(message: e.toString());
    }
  }

  completeSocialSignUp() async {
    if (checkValidation()) {
      try {
        loading.value = true;

        SignUp? signUpRequest = await SignUpService.signSocial(
            name: tempSignUntilUserAddPhone['name'],
            // lastName: nameController.text.split(' ')[1].toString(),
            email: tempSignUntilUserAddPhone['email'],
            phone: phoneController.text,
            provider: tempSignUntilUserAddPhone['provider'],
            provider_id: tempSignUntilUserAddPhone['provider_id'],
            provider_token: tempSignUntilUserAddPhone['provider_token']
        );

        if(signUpRequest!.message == 'Logged in successfully.'.tr && !signUpRequest.data!.isVerified!) {

          loading.value = false;
          errorMessage.value = "";
          toast(message: signUpRequest.message.toString());
          Get.offAll(() => OtpScreen(token: signUpRequest.token??'', phone: phoneController.text,));
        } else if (signUpRequest.message == 'Logged in successfully.'.tr && signUpRequest.data!.isVerified!) {
          toast(message: signUpRequest.message!.tr);

          await sharedPreferenceController.setValue(
              'userData', signUpToJson(signUpRequest));
          sharedPreferenceController.update();

          sharedPreferenceController.userToken.value =
              signUpRequest.token.toString();
          sharedPreferenceController.userToken.refresh();
          Constants.headersWithToken.update(
              'Authorization',
                  (value) =>
              'Bearer ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').userToken.value}');

          sharedPreferenceController.isLoggedIn.value = true;
          sharedPreferenceController.welcomed.value = true;
          sharedPreferenceController.isLoggedIn.refresh();
          sharedPreferenceController.userData.value = signUpRequest;
          sharedPreferenceController.userData.refresh();
          await sharedPreferenceController.setBoolValue("isLoggedIn", true);
          await sharedPreferenceController.setBoolValue("welcomed", true);
          await sharedPreferenceController.setValue(
              "token", signUpRequest.token);
          inspect(signUpRequest.token);

          //  await sharedPreferenceController.setValue(
          // "userData", signUpToJson(signInRequest));
          sharedPreferenceController.update();

          Future.delayed(const Duration(seconds: 2), () {
            Get.offAll(() => HomeScreen());
          });
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