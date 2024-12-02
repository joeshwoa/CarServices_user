import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotePopup extends StatelessWidget {
  final int index;
  AddNotePopup({
    super.key,
    required this.index,
  });
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Add notes'.tr),
      content: Column(
        children: [
          Text(
              'Add notes that is attached to the order and can be viewed by the service provider'
                  .tr),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium,
                cursorColor: ConstantColors.primaryColor,
                controller: cartController.notesControllers[index],
                decoration: InputDecoration(
                  hintText: 'Add Notes'.tr,
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
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Cancel'.tr),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        CupertinoDialogAction(
          child: Text(
            'Add'.tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ],
    );
  }
}
