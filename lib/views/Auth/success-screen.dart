import 'package:autoflex/shared/components/success.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:flutter/material.dart';

class SucessScreen extends StatelessWidget {
  final String type;
  SucessScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.backgroundColor,
      body: SingleChildScrollView(child: sucess(type: type)),
    );
  }
}
