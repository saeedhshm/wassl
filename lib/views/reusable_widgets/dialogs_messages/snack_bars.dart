import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class SnackBars{
  static void showErrorSnackBar(String title, String message){
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      autoDismiss: true,
      // title: 'INFO Reversed',
      autoHide: const Duration(seconds: 4),
      reverseBtnOrder: true,
      // btnOkOnPress: () {},
      // btnCancelOnPress: () {},
      desc:message,
      width: Get.width,
      barrierColor:null,
      descTextStyle: TextStyle(
        color: AppColors.redMissedDayColor,
        fontSize: 16,
        // fontWeight: FontWeight.bold
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      dialogBackgroundColor: null
    ).show();
    return;

    Get.snackbar(title, message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 13500)
    );
  }

  static void showConfirmedSnackBar(String title, String message){
    AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        autoDismiss: true,
        // title: 'INFO Reversed',
        autoHide: const Duration(seconds: 4),
        reverseBtnOrder: true,
        // btnOkOnPress: () {},
        // btnCancelOnPress: () {},
        desc:message,
        width: Get.width,
        barrierColor:null,
        descTextStyle: TextStyle(
            color: AppColors.darkGreyTextColor,
            fontSize: 16,
            // fontWeight: FontWeight.bold
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        dialogBackgroundColor: null
    ).show();
    return;
    Get.snackbar(title, message,
        colorText: Colors.white,
        backgroundColor: Colors.green,
        duration: const Duration(milliseconds: 3500),
      
    );
  }
  static void back(){
    Future.delayed(const Duration(milliseconds: 4610),(){
      Get.back();
    });
  }
}

void show(){
  AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      autoDismiss: true,
      // title: 'INFO Reversed',
      autoHide: const Duration(seconds: 15),
      reverseBtnOrder: true,
      // btnOkOnPress: () {},
      // btnCancelOnPress: () {},
      desc:'message btnCancelOnPress btnCancelOnPress btnCancelOnPress',
      width: Get.width,
      barrierColor:null,
      descTextStyle: TextStyle(
          color: AppColors.darkGreyTextColor,
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      dialogBackgroundColor: null
  ).show();
}