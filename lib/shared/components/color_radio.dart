import 'package:autoflex/main.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorRadio<T> extends StatelessWidget {
  final T value;
  final String? name;
  final ValueChanged<T> onChanged;
  final Gradient? color;
  final String? groupValue;

  const ColorRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.name,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: FractionallySizedBox(
        widthFactor: 0.20,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SizedBox(
            width: 62,
            height: 70,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: ShapeDecoration(
                    gradient: name!.toLowerCase() != 'other'.tr
                        ? color
                        : const SweepGradient(
                            center: Alignment.center, // Use a valid alignment
                            startAngle: 0.0, // Start at 0 radians
                            endAngle:
                                3.14 * 2, // End at 2*pi radians (full circle)
                            colors: [
                              Color(0xFFBFD877),
                              Color(0xFFC98080),
                              Color(0xFF777AB2),
                              Color(0xFF6953C5),
                              Color(0xFFB6C0BD),
                            ],
                          ),
                    shape: OvalBorder(
                      side: BorderSide(
                        color: value != groupValue
                            ? ConstantColors.borderColor
                            : ConstantColors
                                .secondaryColor, // Replace with ConstantColors.secondaryColor
                        width: 1.0, // Set the border width
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(name!,
                    style: TextStyle(
                      color: Color(0xFF717276),
                      fontSize: Get.locale!.languageCode == 'en' ? 13 : 9.5,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.13,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
