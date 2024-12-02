import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/locations/addEmirate-controller.dart';

class AddEmirateScreen extends StatelessWidget {
  AddEmirateScreen({super.key});
  final AddEmirateController controller = Get.put(AddEmirateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ConstantColors.backgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ConstantColors.backgroundColor,
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(top: 16.0),
            child: IconButton(
              icon: SvgPicture.asset(arrowBack),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsetsDirectional.only(top: 16.0),
            child: Text('REQUEST FORM',
                style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
                child: Form(
                  key:controller.addEmirateFormKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textField(
                           hintStyle: Theme.of(context).textTheme.displaySmall,
                             change: (value) {},
                            validate: (value) {
                              
                            },
                            controller: controller.requistController,
                             keyboardType: TextInputType.text,
                            isPassword: false,
                            disabled: true,
                            hint: 'Add New Emirate Request',
                            context: context),
                        const SizedBox(
                          height: 8,
                        ),
                        textField(
                           hintStyle: Theme.of(context).textTheme.displaySmall,
                            change: (value) {},
                            validate: (value) {
                              return Validations.validateName(value!, context);
                            },
                            controller: controller.emirateNameController,
                             keyboardType: TextInputType.name,
                            isPassword: false,
                            disabled: false,
                           
                            hint: 'Emirate Name',
                            context: context),
                        const SizedBox(
                          height: 8,
                        ),
                        textField(
                           hintStyle: Theme.of(context).textTheme.displaySmall,
                           change: (value) {},
                            validate: (value) {
                              return Validations.validateName(value!, context);
                            },
                            controller: controller.nameController,
                             keyboardType: TextInputType.name,
                            isPassword: false,
                            disabled: false,
                            hint: 'Your Name',
                            context: context),
                        const SizedBox(
                          height: 8,
                        ),
                        textField(
                           hintStyle: Theme.of(context).textTheme.displaySmall,
                           change: (value) {},
                            validate: (value) {
                              return Validations.validateEmail(value!, context);
                            },
                            controller: controller.emailController,
                             keyboardType: TextInputType.emailAddress,
                            isPassword: false,
                            disabled: false,
                            hint: 'Email Address',
                            context: context),
                            SizedBox(height: 24,),
                            FormSubmitButton(
                              disabled: false,
                              onPressed: (){
                              controller.addEmirate();
                            },label: 'Submit')
                      ]),
                ))));
  }
}
