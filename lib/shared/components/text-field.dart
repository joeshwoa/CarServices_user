import 'package:autoflex/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget textField({
  dynamic context,
  dynamic keyboardType,
  bool expands = false,
  required Function validate,
  required bool isPassword,
  required Function change,
  required bool disabled,
  dynamic controller,
  dynamic hintStyle,
  String? hint,
  dynamic suffix,
}) {
  return TextFormField(
    textAlignVertical: TextAlignVertical.top,
    // expands: expands,
    maxLines: expands ? 10 : 1,
    style: Theme.of(context).textTheme.bodyMedium,
    readOnly: disabled,
    cursorColor: ConstantColors.primaryColor,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onChanged: (s) => change(s),
    validator: (s) => validate(s),
    keyboardType: keyboardType,
    obscureText: isPassword,
    decoration: InputDecoration(
        hintStyle: hintStyle,
        hintText: hint,
        counterText: "",
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: ConstantColors.borderColor,
              width: 1,
            )),
        isDense: true,
        filled: !disabled,
        fillColor: Colors.white,
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          fontSize: 12.0,
          color: ConstantColors.errorColor,
          // fontWeight: FontWeight.bold,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ConstantColors.errorColor as Color, width: 1),
        ),
        // contentPadding: EdgeInsets.symmetric(vertical:12,horizontal: 16),

        prefixIconConstraints: BoxConstraints(maxHeight: 2.9.h),
        suffixIcon: suffix,
        suffixIconConstraints: BoxConstraints(maxHeight: 5.7.h),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ConstantColors.primaryColor, width: 1.5),
        )),
  );
}
