import 'package:autoflex/controllers/Auth/otp-controller.dart';
import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPhonePopupCustom extends StatefulWidget {
  final String token;
  EditPhonePopupCustom({
    super.key,
    required this.token,
  });

  @override
  State<EditPhonePopupCustom> createState() => _EditPhonePopupCustomState();
}

class _EditPhonePopupCustomState extends State<EditPhonePopupCustom> {
  final otpController = Get.find<OtpController>();

  TextEditingController phoneEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneEditingController = TextEditingController(text: otpController.mobileNumber.value);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Edit phone'.tr),
      content: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
                'Edit phone number and receive new otp'
                    .tr),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                  cursorColor: ConstantColors.primaryColor,
                  controller: phoneEditingController,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Phone number is required'.tr;
                    }
                    if (!value.startsWith("+971")) {
                      phoneEditingController.text = "+971";
                      phoneEditingController.selection =
                          TextSelection.fromPosition(
                            TextPosition(
                                offset: phoneEditingController.text.length),
                          );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Edit phone'.tr,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 119, 119, 119),
                          width: 1,
                        )),
                    isDense: true,
                    fillColor: Colors.white,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ConstantColors.primaryColor, width: 1.5),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Cancel'.tr),
          onPressed: () {
            Get.back();
          },
        ),
        CupertinoDialogAction(
          child: Text(
            'Edit'.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if(formKey.currentState!.validate()) {
              otpController.editPhone(token: widget.token, phone: phoneEditingController.text);
            }
          },
        ),
      ],
    );
  }
}
