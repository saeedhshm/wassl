import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/app_colors.dart';

void successDialog(context, { message, onPress}){
  AwesomeDialog(
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: true,
    title: ''.tr,
    desc:message,
    // barrierColor: AppColors.orangeColorInCalend,
    btnOkColor:AppColors.orangeColorInCalend ,
    // dialogBackgroundColor: AppColors.orangeColorInCalend,
    closeIcon: const SizedBox(),
    btnOkOnPress: () {
      onPress();
    },
    btnOkText: 'ok'.tr,
    btnOkIcon: Icons.check_circle,
    onDismissCallback: (type) {
      debugPrint('Dialog Dissmiss from callback $type');
    },
  ).show();
}


void errorDialog(context, { message, onPress}){
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    headerAnimationLoop: false,
    title: ''.tr,
    btnOkText: 'ok'.tr,
    closeIcon: const SizedBox(),
    desc:message,
    btnOkOnPress: () {},
    btnOkIcon: Icons.cancel,
    btnOkColor: Colors.red,
  ).show();
}

void warningDialogWith2Buttons(context, {required String message,String? btnOkText,IconData? btnOkIcon,onPress}){
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.rightSlide,
    showCloseIcon: false,
    headerAnimationLoop: false,
    title: ''.tr,
    btnOkText: btnOkText ?? 'ok'.tr,
    // closeIcon: const SizedBox(),
    desc:message,
    btnCancelText: 'close'.tr,
    btnOkOnPress: () {

      onPress();
    },
    btnOkIcon: btnOkIcon,
    btnCancelColor: AppColors.redMissedDayColor,
    btnOkColor: AppColors.mainGreenColor,
    btnCancelIcon: Icons.close,
    btnCancelOnPress: (){}
  ).show();
}

void askDialogWith2Buttons(context, {required String message,String? btnOkText,IconData? btnOkIcon,onPress}){
  AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      showCloseIcon: false,
      headerAnimationLoop: false,
      title: ''.tr,
      btnOkText: btnOkText ?? 'ok'.tr,
      // closeIcon: const SizedBox(),
      desc:message,
      btnCancelText: 'close'.tr,
      btnOkOnPress: () {

        onPress();
      },
      btnOkIcon: btnOkIcon,
      btnCancelColor: AppColors.redMissedDayColor,
      btnOkColor: AppColors.mainGreenColor,
      btnCancelIcon: Icons.close,
      btnCancelOnPress: (){}
  ).show();
}