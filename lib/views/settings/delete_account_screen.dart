import 'package:autoflex/controllers/menu/account%20settings/delete_account_controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/delete_pop-up.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DeleteAccountController deleteAccountController =
        Get.put(DeleteAccountController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ConstantColors.backgroundColor,
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(top: 16.0),
            child: IconButton(
              icon: Get.locale?.languageCode == 'en'
                  ? SvgPicture.asset(arrowBack)
                  : Transform.rotate(
                      angle: 3.14,
                      child: SvgPicture.asset(arrowBack),
                    ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsetsDirectional.only(top: 16.0),
            child: Text('DELETE ACCOUNT'.tr,
                style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        body: Form(
          key: deleteAccountController.deleteAccountFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  child: Text(
                    'Are you sure you want to delete your account? This will erase all of your account data and orders from the platform. To delete your account enter your registered phone number below.\n'
                        .tr,
                    style: const TextStyle(
                        color: Color(0xFF959699),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.17,
                        overflow: TextOverflow.visible),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  'This action is irreversable.'.tr,
                  style: const TextStyle(
                    color: Color(0xFFDD0000),
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: -0.17,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: textField(
                    hint: 'Phone Number'.tr,
                    context: context,
                    keyboardType: TextInputType.phone,
                    controller: deleteAccountController.phoneController,
                    isPassword: false,
                    change: (value) {
                      deleteAccountController.isPlaceholderVisible.value =
                          false;
                      if (!value.startsWith("+971")) {
                        deleteAccountController.phoneController.text = "+971";
                        deleteAccountController.phoneController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset: deleteAccountController
                                  .phoneController.text.length),
                        );
                      }
                    },
                    validate: (value) {
                      return Validations.validatePhone(value!, context);
                    },
                    disabled: false,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(
                              color: ConstantColors
                                  .bodyColor2, // Set the border color
                              width: 1.0, // Set the border width
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Get.offAll(() => MenuScreen());
                            },
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  'Cancel'.tr,
                                  style: TextStyle(
                                    color: ConstantColors.bodyColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: localization == "en"
                                        ? GoogleFonts.roboto().fontFamily
                                        : 'DubaiFont',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Material(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: MaterialButton(
                          onPressed: () {
                            deleteAccountController.deleteAccountRequest();
                          },
                          color: ConstantColors.errorColor,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'Delete My Account'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                fontFamily: localization == "en"
                                    ? GoogleFonts.roboto().fontFamily
                                    : 'DubaiFont',
                              ),
                            ),
                          )),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
