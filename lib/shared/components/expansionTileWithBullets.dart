import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExpansionTileWithBullets extends StatelessWidget {
  // final List<String> details;
  final List<String> details;
  final String title;
  final bool isDescription;

  ExpansionTileWithBullets(
      {super.key,
      required this.details,
      required this.title,
      this.isDescription = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> iconsList = [
      SvgPicture.asset(checkCircle),
      SvgPicture.asset(
        steppers,
        color: ConstantColors.secondaryColor,
      ),
      SvgPicture.asset(powerOff),
      SvgPicture.asset(clock)
    ];
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ConstantColors.borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ExpansionTile(
            iconColor: ConstantColors.bodyColor,
            collapsedIconColor: ConstantColors.bodyColor,
            initiallyExpanded: true,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                color: ConstantColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: details
                    .map((data) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16),
                          child: (Row(
                            children: [
                              isDescription
                                  ? iconsList[0]
                                  : (data.contains('Power: '.tr)
                                      ? iconsList[2]
                                      : (data.contains('Duration: '.tr)
                                          ? iconsList[3]
                                          : iconsList[1])),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    data.capitalize!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          overflow: TextOverflow.visible,
                                          color: ConstantColors.bodyColor,
                                        ),
                                  ),
                                ),
                              )
                            ],
                          )),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
