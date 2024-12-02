import 'package:autoflex/controllers/menu/orders_controller.dart';
import 'package:autoflex/models/item_model.dart';
import 'package:autoflex/models/orders.dart' as Orders;
import 'package:autoflex/models/vehiclesModel.dart';
import 'package:autoflex/shared/components/delete_pop-up.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrderItem extends StatelessWidget {
  final String date;
  final String id;
  final String name;
  final String car;
  final double price;
  final double tax;
  final String providerLogo;
  final String status;
  final List<Orders.AddOn> addOns;
  final String notes;
  const OrderItem(
      {super.key,
      required this.date,
      required this.price,
      required this.name,
      required this.addOns,
      required this.id,
      required this.providerLogo,
      required this.car,
      required this.status,
      required this.notes,
      required this.tax});

  @override
  Widget build(BuildContext context) {
    final ordersController = Get.find<OrdersController>();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              //not valid in arabic??????
              color: status == 'pending'
                  ? ConstantColors.borderColor
                  : (status == 'completed'
                      ? ConstantColors.secondaryColor
                      : ConstantColors.errorColor)),
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
                        date,
                        style: const TextStyle(
                          color: Color(0xFF45464C),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                //not valid in arabic???????
                status != 'pending'
                    ? (status == 'completed'
                        ? Text(
                            'Completed'.tr,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: ConstantColors.secondaryColor,
                              fontSize: 9,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          )
                        : Text(
                            'Canceled'.tr,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFFFF0000),
                              fontSize: 9,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ))
                    : InkWell(
                        onTap: () {
                          Get.dialog(
                            DeletePopUp(
                              deletable: 'order'.tr,
                            ),
                          ).then((result) {
                            result ??= false;

                            if (result == true) {
                              ordersController.cancelOrder(id);
                            }
                          });
                        },
                        child: Text(
                          'Cancel Order'.tr,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 9,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
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
                  Image.network(
                    providerLogo,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
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
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          car,
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
                                    '${' ('} ${'incl. VAT AED'.tr} ${' '} ${double.parse((price * tax).toStringAsFixed(2))})',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      height: 1,
                      color: ConstantColors.borderColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
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
                                      '${'AED'.tr} ${addOn.price!.toDouble()}',
                                  style: const TextStyle(
                                    color: Color(0xFF45464C),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.15,
                                  ),
                                ),
                                TextSpan(
                                  text:
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
                    ),
                  ],
                ),
              )),
          //not valid in arabic???????
          status != 'cancelled'
              ? const Divider(
                  height: 1,
                  color: ConstantColors.borderColor,
                )
              : const SizedBox(),
          //not valid in arabic???????
          if (status == 'pending' || status == 'completed')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                children: [
                  SvgPicture.asset(invoice),
                  //not valid in arabic?????????
                  if (status == 'completed')
                    InkWell(
                      onTap: () async {
                        await ordersController.buildPDF(id);
                      },
                      child: Text(
                        'Download Invoice'.tr,
                        style: const TextStyle(
                          color: Color(0xFF45464C),
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  //not valid in arabic??????????
                  if (status == 'pending')
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          notes,
                          style: const TextStyle(
                            color: Color(0xFF45464C),
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
