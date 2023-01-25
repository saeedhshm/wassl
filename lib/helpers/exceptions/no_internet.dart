
import 'package:get/get.dart';

class NoInternetException implements Exception{

  String errorMessage = 'no_internet_exception'.tr;
}

class UserNotFoundException implements Exception{
  String errorMessage = 'wrong_username_password'.tr;
}