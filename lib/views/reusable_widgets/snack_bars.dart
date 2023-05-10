import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SnackBars{
  static void showErrorSnackBar(String title, String message){
    Get.snackbar(title, message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 3500)
    );
  }

  static void showConfirmedSnackBar(String title, String message){
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