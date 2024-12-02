import 'dart:developer';

import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/shared/components/add_note_pop-up.dart';
// import 'package:autoflex/models/item_model.dart';
import 'package:autoflex/shared/components/delete_pop-up.dart';
import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cartItem.dart';

class CartItem extends StatelessWidget {
  final String? date;
  final String id;
  final String name;
  final String? car;
  final double price;
  final double tax;
  final String providerLogo;
  final List<AddOn> addOns;
  final int? index;
  const CartItem({
    super.key,
    required this.date,
    required this.price,
    required this.name,
    required this.addOns,
    required this.id,
    required this.providerLogo,
    this.car,
    this.index,
    required this.tax,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ConstantColors.borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      clock,
                      color: ConstantColors.hintColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        date ?? '',
                        style: const TextStyle(
                          color: Color(0xFF45464C),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.dialog(
                      DeletePopUp(
                        deletable: 'item'.tr,
                      ),
                    ).then((result) {
                      result ??= false;

                      if (result == true) {
                        inspect(id);
                        cartController.deleteItem(id);
                      }
                    });
                  },
                  child: SvgPicture.asset(delete),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: ConstantColors.borderColor,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: providerLogo,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  // Image.asset(
                  //   providerLogo,
                  //   width: 50,
                  //   height: 50,
                  // ),
                  Padding(
                    padding: Get.locale!.languageCode == 'en'
                        ? const EdgeInsets.only(left: 16)
                        : const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.capitalize!,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  height: Get.locale!.languageCode == 'en'
                                      ? null
                                      : 0),
                          maxLines: Get.locale!.languageCode == 'en' ? null : 1,
                        ),
                        Text(
                          car != null ? car!.capitalize! : '',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${'AED'.tr} $price ',
                                style: const TextStyle(
                                  color: ConstantColors.secondaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.15,
                                ),
                              ),
                              TextSpan(
                                text:
                                   '${'('} ${'incl. VAT AED'.tr} ${' '} ${double.parse((price * tax).toStringAsFixed(2))})',
                                style: const TextStyle(
                                  color: ConstantColors.bodyColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.15,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
          ...addOns.map((addOn) => SizedBox(
                child: Column(
                  children: [
                    const Divider(
                      height: 1,
                      color: ConstantColors.borderColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // 'WAX',
                                addOn.name!.capitalize!,
                                style: const TextStyle(
                                  color: Color(0xFF45464C),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          //  'AED 5',
                                          '${addOn.price!}',
                                      style: const TextStyle(
                                        color: Color(0xFF45464C),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.15,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          // ' (incl. VAT AED 5)',
                                          '${' ('} ${'incl. VAT AED'.tr} ${' '} ${double.parse((addOn.price! * tax).toStringAsFixed(2))})',
                                      style: const TextStyle(
                                        color: Color(0xFF45464C),
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.dialog(
                                DeletePopUp(
                                  deletable: 'add-on'.tr,
                                ),
                              ).then((result) {
                                // Ensure a default value if the dialog is dismissed without a button press
                                result ??= false;

                                if (result == true) {
                                  cartController.deleteAddOn(
                                      addOnId: addOn.id!,
                                      itemId: int.parse(id));
                                }
                              });
                            },
                            child: SvgPicture.asset(delete),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          const Divider(
            height: 1,
            color: ConstantColors.borderColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: InkWell(
              onTap: () {
                Get.dialog(
                  AddNotePopup(index: index!),
                ).then((result) {
                  if (result == true) {
                    if (cartController.notesControllers[index!].text != '') {
                      print(cartController.notesControllers[index!].text);
                      cartController.addNote(
                          itemId: int.parse(id),
                          notes: cartController.notesControllers[index!].text);
                    } else {
                      cartController.addNote(itemId: int.parse(id), notes: '');
                    }
                  } else {
                    print(cartController.notesControllers[index!].text);
                    cartController.notesControllers[index!].text = '';
                  }
                });
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    addNote,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      cartController.cart
                                      .firstWhere(
                                          (item) => item.id == int.parse(id))
                                      .notes ==
                                  null ||
                              cartController.cart
                                      .firstWhere(
                                          (item) => item.id == int.parse(id))
                                      .notes ==
                                  ''
                          ? 'Add notes'.tr
                          : cartController.cart
                                  .firstWhere(
                                      (item) => item.id == int.parse(id))
                                  .notes ??
                              '',
                      style: const TextStyle(
                        color: Color(0xFF45464C),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
