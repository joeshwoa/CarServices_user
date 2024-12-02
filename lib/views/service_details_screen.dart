import 'dart:developer';
import 'dart:ffi';
import 'dart:math';
import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/controllers/home/provider_controller.dart';
// import 'package:autoflex/models/provider_model.dart';
import 'package:autoflex/shared/components/Add-on_card.dart';
import 'package:autoflex/shared/components/expansionTileWithBullets.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/cart_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../models/cartItem.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String service;
  final String providerName;
  final String date;
  final dynamic slot_id;
  final String providerLogo;
  double price;
  String day;

  ServiceDetailsScreen(
      {super.key,
      required this.price,
      required this.service,
      required this.providerName,
      required this.date,
      required this.day,
      required this.slot_id,
      required this.providerLogo});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final providerController = Get.find<ProviderController>();
  final cartController = Get.find<CartController>();
  final carController = Get.find<CarController>();
  double total = 0;
  @override
  void initState() {
    total = widget.price;
    inspect(widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = providerController.providers
        .firstWhere((p) => p.name == widget.providerName);
    var serviceDetails =
        provider.products!.firstWhere((s) => s.name == widget.service);
    cartController.total.value = serviceDetails.price!;
    return Obx(
      () => Stack(children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: ConstantColors.backgroundColor,
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.service.toUpperCase()} ',
                    style: const TextStyle(
                      color: ConstantColors.primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.17,
                    ),
                  ),
                  TextSpan(
                    text: '(${'AED'.tr} ${serviceDetails.price})',
                    style: const TextStyle(
                      color: ConstantColors.primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.17,
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
                icon: Get.locale?.languageCode == 'en'
                    ? SvgPicture.asset(arrowBack)
                    : Transform.rotate(
                        angle: 3.14,
                        child: SvgPicture.asset(arrowBack),
                      ),
                onPressed: () {
                  for (var addOn in cartController.boughtAddOns) {
                    inspect(addOn);
                    cartController.total.value =
                        cartController.total.value - (addOn.price ?? 0.0);
                  }
                  cartController.disabledAddOns.clear();
                  cartController.boughtAddOns.clear();
                  Get.back();
                }),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                children: [
                  !providerController.loading.value
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: ConstantColors.borderColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4))),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          3.0), // Adjust the radius as needed
                                      child: CachedNetworkImage(
                                        imageUrl: provider.logo ?? '',
                                        errorWidget: (context, url, error) =>
                                            Image.network(providerLogo,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover),

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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.67,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  provider.name!.toUpperCase(),
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    color: ConstantColors
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                Obx(() {
                                                  var provider =
                                                      providerController
                                                          .providers
                                                          .firstWhere((p) =>
                                                              p.name ==
                                                              widget
                                                                  .providerName);

                                                  var favourited =
                                                      provider.favourite!.obs;

                                                  return InkWell(
                                                    onTap: () {
                                                      providerController
                                                          .updateProviderFavourited(
                                                              provider.id!);
                                                      provider.favourite =
                                                          !provider.favourite!;
                                                    },
                                                    child: Icon(
                                                      favourited.value
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_outline,
                                                      color: favourited.value
                                                          ? ConstantColors
                                                              .secondaryColor
                                                          : ConstantColors
                                                              .borderColor,
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.readOnly(
                                                  /*  onRatingChanged: (rating) {}, */
                                                  size: 20,
                                                  isHalfAllowed: true,
                                                  filledIcon: Icons.star,
                                                  filledColor: ConstantColors
                                                      .secondaryColor,
                                                  emptyIcon: Icons.star_outline,
                                                  emptyColor: ConstantColors
                                                      .secondaryColor,
                                                  halfFilledColor:
                                                      ConstantColors
                                                          .secondaryColor,
                                                  halfFilledIcon:
                                                      Icons.star_half,
                                                  initialRating: double.parse(
                                                      provider.rating!
                                                          .toString()),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '(${provider.votes!})',
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: ConstantColors
                                                        .primaryColor,
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
                                )
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              height: 80,
                              width: double.infinity,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  !providerController.loading.value
                      ? providerController
                              .productDetails.value.description!.isNotEmpty
                          ? ExpansionTileWithBullets(
                              title: 'Service Description'.tr,
                              details: providerController
                                      .productDetails.value.description ??
                                  [])
                          : const SizedBox()
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            height: 200,
                            width: double.infinity,
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  !providerController.loading.value
                      ?
                      // providerController.productDetails.value
                      //         .additionalInformation!.isNotEmpty
                      //     ?
                      ExpansionTileWithBullets(
                          title: 'Additional Information'.tr,
                          isDescription: false,
                          details: [
                                "Power: ".tr +
                                    (providerController.productDetails.value
                                                .powerOutlet
                                                .toString() ==
                                            '0'
                                        ? "No Power Outlet Required".tr
                                        : "Power Outlet Required".tr),
                                "Duration: ".tr +
                                    providerController
                                        .productDetails.value.duration
                                        .toString()
                              ] ??
                              [])

                      // : const SizedBox()
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            height: 80,
                            width: double.infinity,
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  !providerController.loading.value &&
                          providerController
                              .productDetails.value.addOns!.isEmpty
                      ? const SizedBox()
                      : Align(
                          alignment: Get.locale!.languageCode == 'en'
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Text(
                            'Add-ons'.tr,
                            style: const TextStyle(
                                fontSize: 17,
                                color: ConstantColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  !providerController.loading.value
                      ? SizedBox(
                          height: 70,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: providerController
                                .productDetails.value.addOns!
                                .map<Widget>((addOn) {
                              var qty = 1;

                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: AddOnCard(
                                  name: addOn.name!,
                                  cost: addOn.price!,
                                  onPressed: () {
                                    /* if (cartController.disabledAddOns
                                            .contains(addOn.name!) &&
                                        addOn.multiQty!) {
                                      qty++;
                                    } */

                                    cartController.disabledAddOns
                                        .add(addOn.name!);
                                    cartController.total.value += addOn.price!;
                                    cartController.add_ons.add(AddOn(
                                        id: addOn.id,
                                        qty: qty,
                                        name: addOn.name,
                                        price: addOn.price));

                                    cartController.boughtAddOns.add(AddOn(
                                        id: addOn.id,
                                        qty: qty,
                                        name: addOn.name,
                                        price: addOn.price));
                                    inspect(cartController.boughtAddOns);
                                    toast(
                                        message: Get.locale!.languageCode ==
                                                'en'
                                            ? '${addOn.name} added to service successfully'
                                            : 'بنجاح ${addOn.name} تم اضافة');
                                  },
                                  disabled: cartController.disabledAddOns
                                              .contains(addOn.name!) &&
                                          !addOn.multiQty!
                                      ? true
                                      : false,
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : SizedBox(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    height: 80,
                                    width: 150,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    height: 80,
                                    width: 150,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    height: 80,
                                    width: 150,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Container(
                decoration: const BoxDecoration(
                    color: ConstantColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 52,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () {
                      // String date =
                      //     widget.date.substring(3, widget.date.indexOf(','));
                      //     print(date);
                      // DateTime now = DateTime.now();
                      // String monthDay = ' ${DateFormat.yMMMd().format(now)}';
                      // print(monthDay);
                      // date = monthDay +
                      //     widget.date.substring(widget.date.indexOf(','));
                      // Random random = Random();
                      // int randomNumber = random.nextInt(9999 - 1001 + 1) + 1001;
                      // cartController.addItem(item.Item(
                      //     id: providerController.productDetails.value.id.toString(),
                      //     providerLogo:providerLogo,
                      //     // providerLogo: provider.banner,
                      //     car:
                      //         "${carController.car.value.name} (${carController.car.value.color})",
                      //     date: date,
                      //     name: serviceDetails.name,
                      //     price:double.parse(providerController.productDetails.value.price.toString())  ,
                      //     addOns: boughtAddOns
                      //         .map((addOn) => item.AddOn(
                      //             name: addOn.name!, price: addOn.price!))
                      //         .toList()));

                      cartController.addToCartRequest(
                          providerController.selectedProductId.value,
                          carController.car.value.id!,
                          carController.car.value.carType!.id,
                          widget.date,
                          widget.day,
                          widget.slot_id);

/*                       cartController.disabledAddOns.clear(); */
                      /* cartController.boughtAddOns.clear(); */
                      // Get.to(() => CartScreen());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(add),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'ADD TO CART '.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.15,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '(${'AED'.tr} ${cartController.total.value})',
                                      style: const TextStyle(
                                        color: Color(0xFFC8C9CC),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.15,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
        cartController.loading.value ? const LoadingWidget() : Row()
      ]),
    );
  }
}
