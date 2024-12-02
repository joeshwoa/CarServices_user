import 'package:autoflex/main.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectLocationOrVehicle<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String customIcon;
  final String? title;
  final String? layoutType;

  const SelectLocationOrVehicle(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.customIcon,
      this.title,
      required this.layoutType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 2,
                color: value != groupValue
                    ? ConstantColors.borderColor
                    : ConstantColors.secondaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: layoutType == 'row'
            ? Row(
                children: [
                  //not valid in arabic(NOT FIXED YET)
                  value != groupValue
                      ? SvgPicture.asset("assets/images/$customIcon.svg")
                      : SvgPicture.asset(
                          "assets/images/${customIcon}_selected.svg"),
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            : Column(
                children: [
                  //not valid in arabic(NOT FIXED YET)
                  value != groupValue
                      ? SvgPicture.asset("assets/images/$customIcon.svg")
                      : SvgPicture.asset(
                          "assets/images/${customIcon}_selected.svg"),
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
      ),
    );
  }
}
