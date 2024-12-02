import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/home/homeController.dart';

// List<Widget> services = [
//   createButton('CARWASH & DETAILING', carWash),
//   createButton('TYRES & WHEELS', wheels),
//   createButton('ENGINE WORKS', engineWorks),
//   createButton('AC SERVICES', AC),
//   createButton('BATTERY CHARGE', battery),
//   createButton('OIL CHANGE', oil),
//   createButton('TOWING & RECOVERY SERVICES', towing),
//   createButton('SANITIZATION SERVICES', sanitization),
//   createButton('AUTO ELECTRICIAN SERVICES', electric),
// ];

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key});
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: ConstantColors.backgroundColor,
        leading: IconButton(
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
        title: Text(
          'SERVICES'.tr,
          style: const TextStyle(
            fontSize: 21,
            color: ConstantColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          /* IconButton(
            icon: SvgPicture.asset(search),
            onPressed: () {},
          ), */
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
              children: homeController.categories
                  .map((category) => Container(
                        child: category.name != 'All services'.tr
                            ? createButton(
                                category.name.toString().toUpperCase(),
                                category.logoUrl.toString(),
                                category.id as int)
                            : const SizedBox(),
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
