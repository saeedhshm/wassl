import 'dart:convert';

import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/exceptions/location_exceptions.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import 'package:wassl/helpers/exceptions/passwords_exceptions.dart';
import 'package:wassl/models/auth/LoginModel.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';
import 'package:geolocator/geolocator.dart';
import '../helpers/constants/string_constants.dart';


class AppController extends GetxController{

  var loading = false.obs;

  // var loaginSuccessed = false.obs;

  var listOfErrors = <String>[].obs;

  var canUpdate = false;
  var appURL = '';

  var loginModel = LoginModel().obs;
  var rememberMe = true;

  Position? position;

  var deployingForApple = true;

  final _checker = AppVersionChecker();


  Future<void> login({required String email,required String password}) async {


    loading.value = true;
   final response = await AppApiHandler.postData(url: AppUrls.login, body: {
      'email':email,
      'password':password
    });
    int statusCode = response.statusCode;


    loading.value = false;
      if(statusCode == 200){
        if(rememberMe){
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(appStorageEmail, email);
          await prefs.setString(appStoragePassword, password);
        }
        Map<String,dynamic> json = jsonDecode(response.body);

        loginModel.value.fromJson(json);

      }else{
        throw UserNotFoundException();
      }



  }

  Map<String,String> get appHeader{
    return {
  'Authorization':
  'bearer ${loginModel.value.token?.accessToken}',
  // "x-localization": 'lang_code'.tr,
  };
}

  Future<String> changeMyPassword({required String currentPassword, required String newPassword, required String confirmPassword})async{

    final prefs = await SharedPreferences.getInstance();
    String oldPassword = prefs.getString(appStoragePassword) ?? '';

    if(oldPassword != currentPassword){
      throw CurrentPasswordException();
    }

    if(newPassword.length < 6){
      throw PasswordLengthException();
    }

    if(newPassword != confirmPassword) {
      throw NewPassConfirmedPassException();
    }

    loading.value = true;
    var headers = {

      'Authorization':
      'bearer ${loginModel.value.token?.accessToken}',
      "x-localization": 'lang_code'.tr,
    };
    final response = await AppApiHandler.postData(url: AppUrls.changePassword,header: headers ,body: {
      'currentPassword':currentPassword,
      'password':newPassword,
      'confirmPassword':newPassword
    });

    loading.value = false;
    if(response.statusCode != 200){
      throw ChangePasswordException();
    }
    if(response.statusCode == 200){
      await prefs.setString(appStoragePassword, newPassword);
      return 'password_changed';
    }
    return Future.error('password_didnt_change');
  }

 Future logout() async{
   var headers = {
     'Authorization':
     'bearer ${loginModel.value.token?.accessToken}',
     // "x-localization": 'lang_code'.tr,
   };
   loading.value = true;
   final response = await AppApiHandler.getData(url: AppUrls.logout,header: headers,);

   println(response.body);
   loading.value = false;
   if(response.statusCode == 200){
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString(appStorageEmail, 'null');
     await prefs.setString(appStoragePassword, 'null');

     loginModel.value = LoginModel();
   }
  }

  Future<Map<String,String>> retrieveUserAuth() async {
    var userCreds = <String,String>{};
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString(appStorageEmail) ?? 'null';
    final String password = prefs.getString(appStoragePassword) ?? 'null';

    userCreds.addAll({'email':email,'password':password});
    return userCreds;
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkVersion();

  }

  void checkVersion() async {
    var value = await _checker.checkUpdate();

    canUpdate = value.canUpdate;
    appURL = value.appURL ?? '';

  }

  gotoStore() async {
    // println(appURL);
    await launchUrl(Uri.parse(appURL));
  }

  // Future getMyLocation() async {
  //   position  = await _determinePosition();
  //
  //   println('=--=-=-=-=-=-=-=-=-=- position ----');
  //   println(position);
  //   println('=--=-=-=-=-=-=-=-=-=- position ----');
  //
  // }
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<LocationPermission> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    listOfErrors.add('enter determinePosition');
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      listOfErrors.add('serviceEnabled is false');
      throw LocationDisabledException();
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();


    // return Future.error('Location permissions are denied');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        listOfErrors.add(' LocationPermission.denied is LocationDeniedException');
        throw LocationDeniedException();
        // return permission;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      listOfErrors.add('permission == LocationPermission.deniedForever');
      throw LocationDisabledException();
      // return permission;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    position = await Geolocator.getCurrentPosition();
    listOfErrors.add('getCurrentPosition lat: ${position?.latitude} long: ${position?.longitude}');
    return permission;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

}