import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailsField extends StatelessWidget {
  final String label;
  final Widget icon;
  final String data;
  const DetailsField(
      {super.key, required this.label, required this.icon, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge), // Adjust the width for desired space between icon and label
                    Text(data, style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
              icon
              // InkWell(
              //   onTap: () {},
              //   child: SvgPicture.asset(
              //     icon,
              //     color: ConstantColors.bodyColor,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
