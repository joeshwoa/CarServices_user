import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/settings/delete_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Text('ACCOUNT SETTINGS'.tr,
              style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFC8C9CC)),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Delete My Account'.tr,
                    style: const TextStyle(
                      color: Color(0xFF45464C),
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.13,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const DeleteAccountScreen());
                    },
                    child: Text(
                      'DELETE ACCOUNT'.tr,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFFFF0000),
                        fontSize: 11,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.11,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
