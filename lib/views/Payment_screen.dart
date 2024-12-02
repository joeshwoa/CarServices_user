import 'dart:developer';

import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/controllers/home/payment_controller.dart';
import 'package:autoflex/controllers/menu/orders_controller.dart';
import 'package:autoflex/models/cartItem.dart';
// import 'package:autoflex/models/item_model.dart';
import 'package:autoflex/models/orders_model.dart';
import 'package:autoflex/shared/components/cart_item.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/Auth/success-screen.dart';
import 'package:autoflex/views/card_details.dart';
import 'package:autoflex/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  final double subTotal;
  final double vat;
  final List<Item> items;
  final ordersController = Get.find<OrdersController>();
  final cartController = Get.find<CartController>();
  final paymentController = Get.put(PaymentController());
  PaymentScreen(
      {super.key,
      required this.subTotal,
      required this.items,
      required this.vat});

  @override
  Widget build(BuildContext context) {
    inspect(vat);
    double total = double.parse((subTotal + vat).toStringAsFixed(2));
    double tax = double.parse((vat).toStringAsFixed(2));
    return Obx(
      () => Stack(children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: ConstantColors.backgroundColor,
            title: Text(
              "PAYMENT".tr,
              style: const TextStyle(
                color: ConstantColors.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.17,
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
                  Get.back();
                }),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Payment Amount'.tr,
                style: const TextStyle(
                  color: ConstantColors.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.17,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(color: ConstantColors.borderColor),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                children: [
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Sub-Total'.tr,
                          style: const TextStyle(
                            color: Color(0xFF45464C),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          '${'AED'.tr} $subTotal',
                          style: const TextStyle(
                            color: Color(0xFF45464C),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'VAT',
                          style: TextStyle(
                            color: Color(0xFF45464C),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          '${'AED'.tr} $tax',
                          style: const TextStyle(
                            color: Color(0xFF45464C),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: const BoxDecoration(color: Colors.white),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'TOTAL'.tr,
                          style: const TextStyle(
                            color: ConstantColors.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          '${'AED'.tr} $total',
                          style: const TextStyle(
                            color: ConstantColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: ConstantColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: 52,
                      child: TextButton(
                        onPressed: () async {
                          //Get.to(() => CardDetailsScreen(amount: total));
                          String state =
                              await paymentController.paymentByCard();
                          if (state == "success") {
                            cartController.emptyCart();
                            await ordersController.addOrders('card');
                            paymentController.loading.value = false;
                            Get.offAll(() => SucessScreen(
                                  type: 'card',
                                ));
                          } else {
                            paymentController.loading.value = false;
                          }
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(creditCard),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'PAY BY CARD    '.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFFE3E4E5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                        ),
                      ),
                      label: Text(
                        'PAY'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF717276),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.13,
                        ),
                      ),
                      icon: SvgPicture.asset(applePay),
                    ),*/
                    /*TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFFE3E4E5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                        ),
                      ),
                      label: Text(
                        'PAY'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF717276),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.13,
                        ),
                      ),
                      icon: SvgPicture.asset(googlePay),
                    )*/
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 12),
                  decoration: const BoxDecoration(
                      color: ConstantColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 52,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () async {
                        List<Order> orders = items.map((item) {
                          return Order(
                            id: item.id.toString(),
                            name: item.name,
                            date: item.date.toString(),
                            price: double.parse(item.price!),
                            providerLogo: providerLogo,
                            // item.providerLogo,
                            // car: item.car,
                            // addOns: item.addOns,
                            // notes: item.notes,
                            status: 'pending',
                          );
                        }).toList();
                        cartController.emptyCart();
                        ordersController.loading.value = true;
                        await ordersController.addOrders('cashondelivery');
                        Get.offAll(() => SucessScreen(type: 'cashondelivery'));
                        ordersController.loading.value = false;
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(payment),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'CASH ON DELIVERY'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ]),
          ),
        ),
        paymentController.loading.value || ordersController.loading.value
            ? const LoadingWidget()
            : const Row()
      ]),
    );
  }
}
