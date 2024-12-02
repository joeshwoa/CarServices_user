import 'dart:developer';

import 'package:autoflex/controllers/home/provider_controller.dart';
import 'package:autoflex/models/provider_model.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/service_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../models/sellers.dart';

class ProviderCard extends StatelessWidget {
  final int id;
  final bool isPromoted;
  final String providerLogo;
  final String providerName;
  final String date;
  final dynamic slot_id;
  final double rating;
  final int votes;
  bool favourited;
  final String day;
  final List<Product> services;
  ProviderCard(
      {super.key,
      required this.id,
      required this.isPromoted,
      required this.providerLogo,
      required this.providerName,
      required this.favourited,
      required this.votes,
      required this.services,
      required this.rating,
      required this.date,
      required this.day,
      required this.slot_id});

  @override
  Widget build(BuildContext context) {
    final providerController = Get.find<ProviderController>();
    return InkWell(
      onTap: isPromoted && services.length > 0
          ? () {
              providerController.selectedProductId.value = services[0].id!;
              providerController.getProductDetailsRequest();
              Get.to(() => ServiceDetailsScreen(
                    date: date,
                    day: day,
                    slot_id: slot_id,
                    price: double.parse(services[0].price!.toString()),
                    service: services[0].name!,
                    providerName: providerName,
                    providerLogo: providerLogo,
                  ));
            }
          : () {},
      child: Container(
        margin: isPromoted
            ? const EdgeInsets.fromLTRB(8, 16, 8, 16)
            : EdgeInsets.zero,
        width: isPromoted ? 270 : double.infinity,
        decoration: BoxDecoration(
          boxShadow: isPromoted
              ? [
                  const BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 16,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ]
              : [],
          color: Colors.white,
          border: Border.all(
            color: isPromoted
                ? ConstantColors.secondaryColor
                : ConstantColors.borderColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isPromoted
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF00A9DF),
                      shape: RoundedRectangleBorder(
                        borderRadius: Get.locale!.languageCode == 'en'
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomRight: Radius.circular(10),
                              )
                            : const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(10),
                              ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PROMOTED'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        3.0), // Adjust the radius as needed
                    child: CachedNetworkImage(
                      imageUrl: providerLogo,
                      errorWidget: (context, url, error) => Image.asset(
                        providerLogo,
                      ),

                      width: 50,
                      height: 50,
                      fit: BoxFit
                          .cover, // This ensures the image fits the container
                    ),
                  ),
                  Padding(
                    padding: Get.locale!.languageCode == 'en'
                        ? const EdgeInsets.only(left: 16)
                        : const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      width: isPromoted
                          ? 178
                          : MediaQuery.of(context).size.width * 0.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                providerName.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: ConstantColors.primaryColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Obx(() {
                                var provider = providerController.providers
                                    .firstWhere((p) => p.name == providerName);
                                bool favourited = provider.favourite!;

                                return InkWell(
                                  onTap: () {
                                    providerController
                                        .updateProviderFavourited(provider.id!);
                                  },
                                  child: Icon(
                                    favourited
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: favourited
                                        ? ConstantColors.secondaryColor
                                        : ConstantColors.borderColor,
                                  ),
                                );
                              }),
                            ],
                          ),
                          Row(
                            children: [
                              RatingBar.readOnly(
                                size: 20,
                                isHalfAllowed: true,
                                filledIcon: Icons.star,
                                filledColor: ConstantColors.secondaryColor,
                                emptyIcon: Icons.star_outline,
                                emptyColor: ConstantColors.secondaryColor,
                                halfFilledColor: ConstantColors.secondaryColor,
                                halfFilledIcon: Icons.star_half,
                                initialRating: rating,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '($votes)',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: ConstantColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: !isPromoted
                  ? const EdgeInsets.only(bottom: 8.0)
                  : const EdgeInsets.all(0),
              child: Obx(
                () {
                  var _ = providerController.seeMore.value;
                  return Column(
                    children: isPromoted && services.length > 0
                        ? [
                            const Divider(
                              height: 15,
                              color: Color.fromARGB(255, 237, 238, 243),
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${services[0].name!.toString().capitalize}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(height: 0),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${'AED'.tr} ',
                                          style: TextStyle(
                                            color: Color(0xFF00A9DF),
                                            fontSize: 13,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                            letterSpacing: -0.13,
                                          ),
                                        ),
                                        TextSpan(
                                          text: services[0].price.toString(),
                                          style: const TextStyle(
                                            color: Color(0xFF00A9DF),
                                            fontSize: 13,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w900,
                                            height: 0,
                                            letterSpacing: -0.13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ]
                        : List.generate(
                            services.length >= 4 &&
                                    !providerController.seeMore.value
                                ? 3
                                : services.length,
                            (index) => SizedBox(
                              child: Column(
                                children: [
                                  const Divider(
                                    height: 15,
                                    color: Color.fromARGB(255, 237, 238, 243),
                                    thickness: 1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      providerController.selectedProductId
                                          .value = services[index].id!;
                                      providerController
                                          .getProductDetailsRequest();
                                      Get.to(() => ServiceDetailsScreen(
                                            date: date,
                                            day: day,
                                            slot_id: slot_id,
                                            providerLogo: providerLogo,
                                            price: double.parse(services[index]
                                                .price
                                                .toString()),
                                            service: services.length > 0
                                                ? services[index].name!
                                                : '',
                                            providerName: providerName,
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 6, 16, 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${services[index].name!.capitalize}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(height: 0),
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '${'AED'.tr} ',
                                                  style: const TextStyle(
                                                    color: Color(0xFF00A9DF),
                                                    fontSize: 13,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                    letterSpacing: -0.13,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: services[index]
                                                      .price
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Color(0xFF00A9DF),
                                                    fontSize: 13,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w900,
                                                    height: 0,
                                                    letterSpacing: -0.13,
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.right,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  !providerController.seeMore.value
                                      ? Column(
                                          children: [
                                            if (index == 2)
                                              Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: const Divider(
                                                      height: 1,
                                                      color: Color.fromARGB(
                                                          255, 237, 238, 243),
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16),
                                                      child: TextButton.icon(
                                                        onPressed: () {
                                                          providerController
                                                              .seeMore
                                                              .value = true;
                                                        },
                                                        icon: SvgPicture.asset(
                                                            addOutlined),
                                                        label: Text(
                                                          'SEE MORE'.tr,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: ConstantColors
                                                                .secondaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (index == services.length - 1 ||
                                                (services.length > 4 &&
                                                    index == 2))
                                              const SizedBox(height: 8),
                                          ],
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
