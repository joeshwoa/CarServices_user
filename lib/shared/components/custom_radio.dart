import 'dart:math';

import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String customIcon;
  final Widget? title;
  final Widget? subtitle;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.customIcon,
    this.title,
    this.subtitle,
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
        widthFactor: 1,
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                  color: value != groupValue
                      ? ConstantColors.borderColor
                      : ConstantColors.secondaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                width: 8,
              ),
              value != groupValue
                  //not valid in arabic (NOT FIXED YET)
                  ? SvgPicture.asset("assets/images/$customIcon.svg")
                  : SvgPicture.asset(
                      "assets/images/${customIcon}_selected.svg"),
              const SizedBox(width: 8.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (title != null) title!,
                  if (subtitle != null) subtitle!,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
