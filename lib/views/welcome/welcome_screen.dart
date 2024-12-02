import 'package:autoflex/views/Auth/signUp.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controllers/welcome-controller.dart';

final WelcomeController controller = Get.put(WelcomeController());

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                controller.updateIndex(index);
              },
            ),
            items: [
              buildPage(
                  'assets/images/welcome-1.png',
                  'Welcome to Auto Flex!'.tr,
                  'Tap to schedule a wash and enjoy a sparkling clean ride.'.tr,
                  context),
              buildPage(
                  'assets/images/welcome-2.png',
                  'Tap to Request Assistance'.tr,
                  'Find reliable fixing and towing service providers to get back on the road fast.'
                      .tr,
                  context),
              buildPage(
                  'assets/images/welcome-3.png',
                  'Register Today!'.tr,
                  'Unlock exclusive offers and enjoy hassle-free services tailored just for you.'
                      .tr,
                  context),
            ],
          ),
          Positioned(
            bottom: 60.0,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Expanded(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(3, (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            height: 10.0,
                            width: controller.currentIndex.value == index
                                ? 20.0
                                : 10.0,
                            decoration: BoxDecoration(
                              color: controller.currentIndex.value == index
                                  ? Colors.white
                                  : Colors.white54,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          );
                        }),
                      ),
                    )),
                Spacer(),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 2.8,
                // ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: Text(
                        'SKIP'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => SignUpScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(
                            side: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 0.40))),
                        padding: EdgeInsets.all(10),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(
      String imagePath, String title, String subtitle, dynamic context) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 120),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 13),
            Text(
              subtitle,
              style: TextStyle(
                overflow: TextOverflow.visible,
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
