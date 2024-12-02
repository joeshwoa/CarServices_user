import 'dart:convert';
import 'dart:io';

import 'package:autoflex/models/signUp.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:get/get.dart';

import '../../shared/constants.dart';
import 'package:http/http.dart' as http;

final SharedPreferenceController sharedPreferenceController =
    Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');

class SignUpService {

  static Future<String> requestOtp({
    required String token,
  }) async {
    var response = await Constants.postNetworkServiceWithOptionalToken(
        "v1/customer/send/otp", "withToken", {
          "iso":await sharedPreferenceController.getValue('localization'),
        }
        , optionalToken: token,
        
        );
    print(response.body);

    return json.decode(response.body)["message"];
  }
  static Future<String> verifyOtp({
    required String token,
    required String otp,
  }) async {
    var response = await Constants.postNetworkServiceWithOptionalToken(
        "v1/customer/verify", "withToken", {
          "otp": otp,
          "iso":await sharedPreferenceController.getValue('localization'),
    }
    , optionalToken: token
    );
    print(token);
    print(response.body);

    return json.decode(response.body)["message"];
  }
  static Future<SignUp?> signSocial({
    required String name,
    // required String lastName,
    required String email,
    String phone = "",
    required String provider,
    required String provider_id,
    required String provider_token,
  }) async {
    var response = await Constants.postNetworkService(
        "v1/customer/login/social", "withoutToken", {
      "full_name": name,
      // "last_name": lastName,
      "email": email,
      if(phone.isNotEmpty)"phone": phone,
      
      "device_name": await sharedPreferenceController.getValue('uuid'),
      "provider":provider,
      "provider_id":provider_id,
      "provider_token":provider_token,
      "iso":await sharedPreferenceController.getValue('localization'),
    });
    print(response.body);

    var result = signUpFromJson(response.body);
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<SignUp?> signUp({
    required String name,
    // required String lastName,
    required String email,
    required String password,
    required String password_confirmation,
    required String phone,
    String? whatsapp,
  }) async {
    var response = await Constants.postNetworkService(
        "v1/customer/register", "withoutToken", {
      "full_name": name,
      // "last_name": lastName,
      "email": email,
      "password": password,
      "password_confirmation": password_confirmation,
      "phone": phone,
      whatsapp=='+971'?"":"whatsapp_number": whatsapp,

      "device_name": await sharedPreferenceController.getValue('uuid'),
      "iso":await sharedPreferenceController.getValue('localization'),
    });
    print(whatsapp);
    print(response.body);

    var result = signUpFromJson(response.body);
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<SignUp?> editProfile({
    String? name,
    String? gender,
    String? dateOfBirth,
    String? email,
    String? phone,
    String? whatsapp,
    String token = '',
    dynamic? image,
    required String? type,
  }) async {
    var response;

    switch (type) {
      case 'name':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "full_name": name,
        });
        break;
      case 'email':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "email": email,
        });
        break;
      case 'phone':
        response = await Constants.postNetworkServiceWithOptionalToken(
            "v1/customer/profile?_method=PUT", "withToken", {
          "phone": phone,
        },
          optionalToken: token,
          );
        break;
      case 'whatsapp':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "whatsapp_number": whatsapp,
        });
        break;
      case 'gender':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "gender": gender,
        });
        break;
      case 'dob':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "date_of_birth": dateOfBirth,
        });
        break;
      case 'image':
        //  var multipartFile = await http.MultipartFile.fromPath("image", image!);
        response = await Constants.multipartrequestNetworkService(
          "v1/customer/profile?_method=PUT",
          "withToken",
          image,
        );
        break;
    }
    print(response.body);

    var result = signUpFromJson(response.body);
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<SignUp?> sigIn({
    required String email,
    required String password,
  }) async {
    var response = await Constants.postNetworkService(
        "v1/customer/login", "withoutToken", {
      "email": email,
      "password": password,
      "device_name": await sharedPreferenceController.getValue('uuid'),
      "iso":await sharedPreferenceController.getValue('localization'),
    });

    var result = signUpFromJson(response.body);
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<dynamic?> signout() async {
    var response = await Constants.postNetworkService(
        "v1/customer/logout", "withToken", {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = jsonDecode(response.body);
      if (result != null) {
        return result;
      } else {
        return null;
      }
    } else {
      return 'an error occoured ${response.statusCode}';
    }
  }

  static Future<String> forgetPasswordRequest({required String email}) async {
    var response = await Constants.postNetworkService(
        "v1/customer/forgot-password", "withoutToken", {
          "email": email,
    });

    return json.decode(response.body)['message'];
  }
}
