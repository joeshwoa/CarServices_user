import 'dart:developer';

import 'package:autoflex/controllers/home/appointmentDetailsController.dart';
import 'package:autoflex/controllers/home/provider_controller.dart';
import 'package:autoflex/shared/components/provider_card.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProviderSelectionScreen extends StatelessWidget {
  final String title;
  final String dateTime;
  final String date;
  final String day;
  final dynamic slotId;
  ProviderSelectionScreen(
      {super.key,
      required this.title,
      required this.dateTime,
      required this.date,
      required this.day,
      required this.slotId});

  final ProviderController providerController = Get.put(ProviderController());
  final AppointmentDetailsController appointmentDetailsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: ConstantColors.backgroundColor,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              color: ConstantColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Text(
                'Close'.tr,
                style: const TextStyle(
                  fontSize: 15,
                  color: ConstantColors.secondaryColor,
                ),
              ),
              onPressed: () {
                Get.off(() => HomeScreen());
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: providerController.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search'.tr,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintStyle: const TextStyle(
                        color: ConstantColors.hintColor,
                        fontWeight: FontWeight.normal),
                    prefixIcon: const Icon(Icons.search,
                        color: ConstantColors.hintColor, size: 18),
                    suffixIcon: InkWell(
                      onTap: () {
                        providerController.searchController.text = '';
                        providerController.getSellersRequest(
                            providerController.searchController.text);
                      },
                      child: const Icon(
                        Icons.close,
                        color: ConstantColors.hintColor,
                        size: 15,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: ConstantColors.hintColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: ConstantColors.hintColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: ConstantColors.secondaryColor),
                    ),
                  ),
                  onChanged: (value) {
                    providerController.getSellersRequest(value);
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: Get.locale?.languageCode == 'en'
                            ? const EdgeInsets.only(right: 10)
                            : const EdgeInsets.only(left: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: ConstantColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 44,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: SvgPicture.asset(schedule),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        '${day} ${date.split('-')[2]}, ${appointmentDetailsController.slots.firstWhere((slot) => slot['id'] == slotId)['from']} - ${appointmentDetailsController.slots.firstWhere((slot) => slot['id'] == slotId)['to']}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                items: const [],
                                onChanged: (value) {},
                                icon: const SizedBox(),
                                underline: const SizedBox(),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 44,
                      width: 52,
                      child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(filter),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ConstantColors.primaryColor),
                            side: MaterialStateProperty.all(BorderSide.none),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                          )),
                    )
                  ],
                ),
              ),
              !providerController.loading.value
                  ? Container(
                      height: 188,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: providerController.providers.map((provider) {
                          if (provider.promoted == true) {
                            inspect(date);
                            return ProviderCard(
                              id: provider.id!,
                              day: day,
                              date: date,
                              isPromoted: true,
                              providerLogo: provider.logo ?? providerLogo,
                              providerName: provider.name!,
                              favourited: provider.favourite!,
                              votes: provider.votes!,
                              services: provider.products!,
                              rating: provider.rating!,
                              slot_id: slotId,
                            );
                          } else {
                            return const SizedBox();
                          }
                        }).toList(),
                      ),
                    )
                  : SizedBox(
                      height: 188,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                height: 188,
                                width: 286,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                height: 188,
                                width: 286,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              !providerController.loading.value
                  ? Container(
                      child: Column(
                        children: List.generate(
                            providerController.providers.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  child: ProviderCard(
                                      id: providerController
                                          .providers[index].id!,
                                      date: date,
                                      day: day,
                                      slot_id: slotId,
                                      isPromoted: false,
                                      providerLogo: providerController
                                              .providers[index].logo ??
                                          providerLogo,
                                      // providerController.providers[index].banner.toString(),
                                      providerName: providerController
                                          .providers[index].name
                                          .toString(),
                                      favourited:
                                          //  false,
                                          providerController
                                              .providers[index].favourite!,
                                      votes:
                                          //  20,
                                          providerController
                                              .providers[index].votes!,
                                      services: providerController
                                          .providers[index].products!,
                                      rating:
                                          // 3,
                                          providerController
                                              .providers[index].rating!),
                                )),
                      ),
                    )
                  : SizedBox(
                      child: Column(
                        children: List.generate(
                            5,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      height: 200,
                                      width: double.infinity,
                                    ),
                                  ),
                                )),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
