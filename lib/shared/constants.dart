import 'dart:convert';
import 'dart:ui';

import 'package:autoflex/views/welcome/welcome_screen.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'shared_preference.dart';

class Constants {
  static var client = ChuckerHttpClient(http.Client());
  static const String baseUrl = 'https://autoflex.innovationbox.ae';
  static const String apiKey = 'https://autoflex.innovationbox.ae/api';

  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-type': 'application/json',
    'iso': Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
        .localization
        .value
  };
  static Map<String, String> headersWithToken = {
    'Accept': 'application/json',
    'Content-type': 'application/json',
    'Authorization':
        'Bearer ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').userToken.value}',
    'iso': Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
        .localization
        .value
  };
  static udateLocal(String lang) async {
    if (lang == 'ar') {
      Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
          .localization
          .value = 'ar';
      await Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
          .setValue('localization', 'ar');
      Get.updateLocale(Locale('ar'));
    } else {
      Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
          .localization
          .value = 'en';
      await Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
          .setValue('localization', 'en');
      Get.updateLocale(Locale('en'));
    }
      Get.to(() => WelcomeScreen());
  }

  static Future<dynamic> getNetworkService(String api, String headersType) {
    if (kDebugMode) {
      print(headersWithToken);
    }
    return client.get(Uri.parse('$apiKey/$api'),
        headers: headersType == "withToken" ? headersWithToken : headers);
  }

  static Future<http.Response> postNetworkServiceWithOptionalToken(
      String api, String headersType, Map<String, dynamic> body,
      {String? optionalToken}) {
    return client.post(
      Uri.parse('$apiKey/$api'),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer $optionalToken',
        'iso': Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
            .localization
            .value
      },
      body: json.encode(body),
    );
  }

  static Future<http.Response> postNetworkService(
      String api, String headersType, Map<String, dynamic> body
      // , {String? optionalToken }
      ) {
    // print(optionalToken);
    return client.post(
      Uri.parse('$apiKey/$api'),
      headers: headersType == "withToken" ? headersWithToken : headers,
      // headers: headersType == "withToken"
      // ?( optionalToken == '' ? headersWithToken :  {
      //   'Accept': 'application/json',
      //   'Content-type': 'application/json',
      //   'Authorization':
      //   'Bearer $optionalToken',
      //   'lang': Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
      //       .localization
      //       .value
      // }): headers,

      body: json.encode(body),
    );
  }

  static Future<http.Response> putNetworkService(
      String api, String headersType, Map<String, dynamic> body) {
    return client.put(
      Uri.parse('$apiKey/$api'),
      headers: headersType == "withToken" ? headersWithToken : headers,
      body: json.encode(body),
    );
  }

  static Future<http.Response> deleteNetworkService(
      String api, String headersType, Map<String, dynamic> body) {
    return client.delete(
      Uri.parse('$apiKey/$api'),
      headers: headersType == "withToken" ? headersWithToken : headers,
      body: json.encode(body),
    );
  }

  static Future<http.Response?> multipartrequestNetworkService(
      String api,
      String headersType,
      // Map<String, String> body,
      String? image,
      {String optionalToken = ''}) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse('$apiKey/$api'));
      if (image != "") {
        var multipartFile = await http.MultipartFile.fromPath("image", image!);
        request.files.add(multipartFile);
      }

      request.headers.addAll(headersType == "withToken"
          ? (optionalToken.isEmpty
              ? headersWithToken
              : {
                  'Accept': 'application/json',
                  'Content-type': 'application/json',
                  'Authorization': 'Bearer $optionalToken',
                  'iso': Get.find<SharedPreferenceController>(
                          tag: 'tagsAreEverywhere')
                      .localization
                      .value
                })
          : headers);

      // request.fields.addAll(body);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
      // final respStr = await response.
      if (kDebugMode) {
        print("response");
        print(response);
      }
      return response;
    } catch (err) {
      if (kDebugMode) {
        print("err");
        print(err);
      }
    }
    return null;
  }
}
