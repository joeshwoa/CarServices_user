import 'dart:ffi';

import 'package:autoflex/controllers/menu/account%20settings/personal_data_controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/details_field.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:autoflex/views/Auth/social-sign-up.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDetailsScreen extends StatelessWidget {
  PersonalDetailsScreen({super.key});
  final SharedPreferenceController sharedPreferenceController =
      Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
  final PersonalDataController personalDataController =
      Get.put(PersonalDataController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: ConstantColors.backgroundColor,
          title: Text(
            'PERSONAL DETAILS'.tr,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: IconButton(
              icon: Get.locale?.languageCode == 'en'
                  ? SvgPicture.asset(arrowBack)
                  : Transform.rotate(
                      angle: 3.14,
                      child: SvgPicture.asset(arrowBack),
                    ),
              onPressed: () {
                Get.back();
              }),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        sharedPreferenceController
                                .userData.value.data!.fullName ??
                            sharedPreferenceController
                                    .userData.value.data!.firstName +
                                ' ' +
                                sharedPreferenceController
                                    .userData.value.data!.lastName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    surfaceTintColor: Colors.white,
                                    title: Text('Update your full name'.tr),
                                    content: textField(
                                        change: (value) {},
                                        validate: (value) {
                                          return Validations.validateName(
                                              value!, context);
                                        },
                                        controller: personalDataController
                                            .nameController,
                                        keyboardType: TextInputType.name,
                                        isPassword: false,
                                        disabled: false,
                                        context: context),
                                    actions: <Widget>[
                                      MaterialButton(
                                        color: ConstantColors.primaryColor,
                                        textColor: Colors.white,
                                        child: Text('Update'.tr),
                                        onPressed: () {
                                          personalDataController
                                              .editProfile('name');
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: SvgPicture.asset(edit_blue))
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      uploadImageBottomSheet(context);
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 16,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                            color: Colors.white,
                            border: Border.all(
                                color: ConstantColors.secondaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(9999)),
                          ),
                          child: sharedPreferenceController
                                          .userData.value.data!.image !=
                                      null &&
                                  sharedPreferenceController
                                      .userData.value.data!.image!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: sharedPreferenceController
                                      .userData.value.data!.image!,
                                  width: 65,
                                  height: 65,
                                )
                              : Image.asset(
                                  "assets/images/avatar.png",
                                  width: 65,
                                  height: 65,
                                ),
                        ),
                        SvgPicture.asset(
                          change,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ConstantColors.borderColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                foregroundDecoration: BoxDecoration(
                  border: Border.all(color: ConstantColors.borderColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: DetailsField(
                            label: 'Phone Number'.tr,
                            icon: SvgPicture.asset(checkCircle),
                            data: sharedPreferenceController
                                .userData.value.data!.phone!),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: ConstantColors.borderColor,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: DetailsField(
                            label: 'Whats App Number'.tr,
                            icon: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          surfaceTintColor: Colors.white,
                                          title: Text(
                                              'Update your Whats App Number'
                                                  .tr),
                                          content: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: textField(
                                                change: (value) {},
                                                validate: (value) {
                                                  return Validations
                                                      .validatePhone(
                                                          value!, context);
                                                },
                                                controller:
                                                    personalDataController
                                                        .whatsappController,
                                                keyboardType:
                                                    TextInputType.phone,
                                                isPassword: false,
                                                disabled: false,
                                                context: context),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              color:
                                                  ConstantColors.primaryColor,
                                              textColor: Colors.white,
                                              child: Text('Update'.tr),
                                              onPressed: () {
                                                personalDataController
                                                    .editProfile('whatsapp');
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: SvgPicture.asset(
                                    "assets/images/border_color_selected.svg")),
                            data: sharedPreferenceController
                                        .userData.value.data!.whatsappNumber ==
                                    null
                                ? ""
                                : sharedPreferenceController
                                    .userData.value.data!.whatsappNumber!),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: ConstantColors.borderColor,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: DetailsField(
                          label: 'Email Address'.tr,
                          icon: InkWell(
                              onTap: () {},
                              child: Text(''
                                  // 'Verify'.toUpperCase(),
                                  // style: Theme.of(context).textTheme.labelSmall,
                                  )),
                          data: sharedPreferenceController
                              .userData.value.data!.email!),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ConstantColors.borderColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(color: ConstantColors.borderColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: DetailsField(
                            label: 'Gender'.tr,
                            icon: InkWell(
                                onTap: () {
                                  genderBottomSheet(context);
                                },
                                child: sharedPreferenceController
                                            .userData.value.data!.gender ==
                                        null
                                    ? Text(
                                        'ADD'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          genderBottomSheet(context);
                                        },
                                        child: SvgPicture.asset(
                                            "assets/images/border_color_selected.svg"))),
                            data: sharedPreferenceController
                                        .userData.value.data!.gender ==
                                    null
                                ? 'Add Your Gender'.tr
                                : sharedPreferenceController
                                    .userData.value.data!.gender!),
                      ),
                      const Divider(
                        height: 1,
                        color: ConstantColors.borderColor,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: DetailsField(
                            label: 'Birthday'.tr,
                            icon: InkWell(
                                onTap: () {
                                  showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (_) {
                                        final size =
                                            MediaQuery.of(context).size.width -
                                                40;

                                        return Center(
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12),
                                                ),
                                              ),
                                              height: 213,
                                              width: 297,
                                              child: Column(
                                                // crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                      child: SafeArea(
                                                    top: false,
                                                    child: CupertinoDatePicker(
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .date,
                                                        maximumDate:
                                                            DateTime.now(),
                                                        initialDateTime:
                                                            DateTime.now()
                                                                .subtract(
                                                                    Duration(
                                                                        seconds:
                                                                            1)),
                                                        use24hFormat: true,
                                                        onDateTimeChanged:
                                                            (value) {
                                                          personalDataController
                                                                  .selectedDOB
                                                                  .value =
                                                              value
                                                                  .toString()
                                                                  .split(
                                                                      ' ')[0];
                                                        }),
                                                  )),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  MaterialButton(
                                                    minWidth: double.infinity,
                                                    color: ConstantColors
                                                        .primaryColor,
                                                    textColor: Colors.white,
                                                    child: Text('Update'.tr),
                                                    onPressed: () {
                                                      personalDataController
                                                          .editProfile('dob');
                                                    },
                                                  ),
                                                ],
                                              )),
                                        );
                                      });
                                },
                                child: sharedPreferenceController
                                            .userData.value.data!.dateOfBirth ==
                                        null
                                    ? Text(
                                        'ADD'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          showCupertinoModalPopup<void>(
                                              context: context,
                                              builder: (_) {
                                                final size =
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        40;

                                                return Center(
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(12),
                                                        ),
                                                      ),
                                                      height: 213,
                                                      width: 297,
                                                      child: Column(
                                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Expanded(
                                                              child: SafeArea(
                                                            top: false,
                                                            child:
                                                                CupertinoDatePicker(
                                                                    mode: CupertinoDatePickerMode
                                                                        .date,
                                                                    maximumDate:
                                                                        DateTime
                                                                            .now(),
                                                                    initialDateTime: DateTime
                                                                            .now()
                                                                        .subtract(Duration(
                                                                            seconds:
                                                                                1)),
                                                                    use24hFormat:
                                                                        true,
                                                                    onDateTimeChanged:
                                                                        (value) {
                                                                      personalDataController
                                                                          .selectedDOB
                                                                          .value = value
                                                                              .toString()
                                                                              .split(' ')[
                                                                          0];
                                                                    }),
                                                          )),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          MaterialButton(
                                                            minWidth:
                                                                double.infinity,
                                                            color: ConstantColors
                                                                .primaryColor,
                                                            textColor:
                                                                Colors.white,
                                                            child: Text(
                                                                'Update'.tr),
                                                            onPressed: () {
                                                              personalDataController
                                                                  .editProfile(
                                                                      'dob');
                                                            },
                                                          ),
                                                        ],
                                                      )),
                                                );
                                              });
                                        },
                                        child: SvgPicture.asset(
                                            "assets/images/border_color_selected.svg"))),
                            data: sharedPreferenceController
                                        .userData.value.data!.dateOfBirth ==
                                    null
                                ? 'Add Your Birthday'.tr
                                : sharedPreferenceController
                                    .userData.value.data!.dateOfBirth!
                                    .toString()),
                      ),
                      const Divider(
                        height: 1,
                        color: ConstantColors.borderColor,
                      )
                    ],
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  Future<dynamic> uploadImageBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 30, maxHeight: 228),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        // backgroundColor: ConstantColors.backgroundColor,
        builder: (BuildContext context) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  InkWell(
                    onTap: () {
                      personalDataController.changePhotoRequest('camera');
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Take Photo'.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          SvgPicture.asset(cameraIcon)
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: ConstantColors.borderColor,
                  ),
                  InkWell(
                    onTap: () {
                      personalDataController.changePhotoRequest('gallery');
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Photo Library'.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          SvgPicture.asset(imagePlaceholder_selected)
                        ],
                      ),
                    ),
                  ),
                  //   const Divider(
                  //     height: 1,
                  //     color: ConstantColors.borderColor,
                  //   ),
                  //  InkWell(
                  //     onTap: () {
                  //       Get.back();
                  //     },
                  //     child: Padding(
                  //          padding: const EdgeInsets.all( 16.0),
                  //       child: Row(
                  //         mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             'Browse',
                  //             style: Theme.of(context).textTheme.displayLarge
                  //           ),
                  //           SvgPicture.asset(moreIcon)
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                ]),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        'Cancel'.tr,
                        style: TextStyle(
                          color: ConstantColors.secondaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: localization == "en"
                              ? GoogleFonts.roboto().fontFamily
                              : 'DubaiFont',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        context: context);
  }

  Future<dynamic> genderBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 30,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        // backgroundColor: ConstantColors.backgroundColor,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Select Your Gender'.tr,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 12.5,
                    ),
                    const Divider(
                      height: 1,
                      color: ConstantColors.borderColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17.0),
                      child: InkWell(
                        onTap: () async {
                          // Get.back();
                          personalDataController.selectedGender.value =
                              'Male'.tr;
                          personalDataController.editProfile('gender');
                        },
                        child: Text(
                          'Male'.tr,
                          style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontFamily: localization == "en"
                                ? GoogleFonts.roboto().fontFamily
                                : 'DubaiFont',
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: ConstantColors.borderColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17.0),
                      child: InkWell(
                        onTap: () {
                          personalDataController.selectedGender.value =
                              'Female'.tr;
                          personalDataController.editProfile('gender');
                        },
                        child: Text(
                          'Female'.tr,
                          style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontFamily: localization == "en"
                                ? GoogleFonts.roboto().fontFamily
                                : 'DubaiFont',
                          ),
                        ),
                      ),
                    ),
                    // const Divider(
                    //   height: 1,
                    //   color: ConstantColors.borderColor,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 17.0),
                    //   child: InkWell(
                    //     onTap: () {
                    //       personalDataController.selectedGender.value='Don’t want to specify';
                    //       personalDataController.editProfile('gender');
                    //     },
                    //     child: Text(
                    //       'Don’t want to specify',
                    //       style: TextStyle(
                    //         color: Color(0xFF007AFF),
                    //         fontSize: 17,
                    //         fontWeight: FontWeight.w400,
                    //         fontFamily: localization == "en"
                    //             ? GoogleFonts.roboto().fontFamily
                    //             : 'DubaiFont',
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        'Cancel'.tr,
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: localization == "en"
                              ? GoogleFonts.roboto().fontFamily
                              : 'DubaiFont',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
        context: context);
  }
}
