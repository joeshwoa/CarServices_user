import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/views/cart_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddOnCard extends StatelessWidget {
  final String name;
  final double cost;
  final VoidCallback onPressed;
  bool disabled;
  AddOnCard(
      {super.key,
      required this.name,
      required this.cost,
      required this.onPressed,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ConstantColors.secondaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.capitalize!,
                  style: const TextStyle(
                    color: ConstantColors.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${'AED'.tr} ',
                        style: const TextStyle(
                          color: ConstantColors.primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.17,
                          height: 1.0,
                        ),
                      ),
                      TextSpan(
                        text: cost.toString().capitalizeFirst,
                        style: const TextStyle(
                          color: ConstantColors.primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.17,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            OutlinedButton(
                onPressed: disabled ? null : onPressed,
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  minimumSize: const MaterialStatePropertyAll(Size.zero),
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 4, horizontal: 12)),
                  side: MaterialStatePropertyAll(BorderSide(
                      color: disabled
                          ? ConstantColors.borderColor
                          : ConstantColors.secondaryColor)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                ),
                child: Text(
                  'ADD'.tr, // Assuming cost is a variable containing the price
                  style: TextStyle(
                    color: disabled
                        ? const Color(0xFF717276)
                        : ConstantColors.secondaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.17,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
