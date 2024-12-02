import 'dart:math';

import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/locations/addLocation.dart';
import 'package:autoflex/views/vehicles/add_vehicles_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LocationVehicleRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String? customIcon;
  final String? editIcon;
  final Function? edit;
  final Widget? title;
  final Widget? subtitle;
  final String type;
  final String? screenName;

  const LocationVehicleRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.customIcon,
    this.editIcon,
    this.edit,
    this.title,
    this.subtitle,
    required this.type,
    this.screenName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
          /* edit!(); */
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            border: value == groupValue
                ? Border.all(color: ConstantColors.secondaryColor)
                : const Border(
                    bottom: BorderSide(
                        width: 0, color: ConstantColors.borderColor)),
            borderRadius: value == groupValue
                ? const BorderRadius.all(Radius.circular(10))
                : const BorderRadius.all(Radius.circular(0))),
        child: Row(
          children: <Widget>[
            //not vaild in arabic
            value != groupValue
                ? SvgPicture.asset("assets/images/$customIcon.svg")
                : SvgPicture.asset("assets/images/${customIcon}_selected.svg"),
            screenName == 'myLocations' || screenName == 'myVehicles'
                ? const SizedBox(width: 12.0)
                : const SizedBox(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (title != null) title!,
                  if (subtitle != null) subtitle!,
                ],
              ),
            ),
            //not vaild in arabic
            value != groupValue
                ? SvgPicture.asset("assets/images/$editIcon.svg")
                : IconButton(
                    onPressed: () => {edit!()},
                    icon: SvgPicture.asset(
                        "assets/images/${editIcon}_selected.svg"))
          ],
        ),
      ),
    );
  }
}
