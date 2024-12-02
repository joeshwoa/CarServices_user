import 'package:autoflex/shared/constants.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:autoflex/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../styles/colors.dart';

class ChooseLangScreen extends StatelessWidget {
  ChooseLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferenceController sharedPreferenceController =
        Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset('assets/images/Language.png').image,
                fit: BoxFit.fill)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16,
                bottom: MediaQuery.of(context).size.height / 7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(255, 255, 255, 0.40)),
                      borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                    onPressed: ()  {
                      // // Get.updateLocale(Locale('ar'));
                      // sharedPreferenceController.updateLocale('ar');
                      // sharedPreferenceController.localization.value = 'ar';
                      // await sharedPreferenceController.setValue(
                      //     'localization', 'ar');
                      //   // await sharedPreferenceController.changeLocale();
                      // Get.to(() => WelcomeScreen());
                      
                       Constants.udateLocal('ar');
                       print("choose lang ${sharedPreferenceController.localization.value}");
                      // sharedPreferenceController.localization.refresh();
                      // sharedPreferenceController.update();
                    },
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'الـعـربـيــة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          fontFamily: localization == "en"
                              ? GoogleFonts.roboto().fontFamily
                              : 'DubaiFont',
                        ),
                      ),
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(255, 255, 255, 0.40)),
                      borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                    onPressed: ()  {
                      // Get.updateLocale(Locale('en'));
                      // sharedPreferenceController.localization.value = 'en';
                      // await sharedPreferenceController.setValue(
                      //     'localization', 'en');
                      // // await sharedPreferenceController.changeLocale();
                      // Get.to(() => WelcomeScreen());
                       Constants.udateLocal('en');
                    print("choose lang ${sharedPreferenceController.localization.value}");
                      // sharedPreferenceController.localization.refresh();
                      // sharedPreferenceController.update();
                    },
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'ENGLISH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          fontFamily: localization == "en"
                              ? GoogleFonts.roboto().fontFamily
                              : 'DubaiFont',
                        ),
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
