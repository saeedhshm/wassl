import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SnackBars{
  static void showErrorSnackBar(String title, String message){
    Get.snackbar(title, message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

  static void showConfirmedSnackBar(String title, String message){
    Get.snackbar(title, message,
        colorText: Colors.white,
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 2500)
    );
  }
}