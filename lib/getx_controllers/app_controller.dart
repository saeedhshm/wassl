import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/auth/LoginModel.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';
import 'package:geolocator/geolocator.dart';
import '../helpers/constants/sring_constans.dart';
import 'calendar/calendar_controller.dart';

class AppController extends GetxController{

  var loading = false.obs;

  var loaginSuccessed = false.obs;

  var loginModel = LoginModel().obs;
  var rememberMe = true;

  late Position position;


  Future<bool> login({required String email,required String password}) async {

    if(rememberMe){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(appStorageEmail, email);
      await prefs.setString(appStoragePassword, password);
    }
    loading.value = true;
   final response = await AppApiHandler.sendData(url: AppUrls.login, body: {
      'email':email,
      'password':password
    });
    int statusCode = response.statusCode;

println(response.statusCode);
println(response.body);
    loading.value = false;
      if(statusCode == 200){
        Map<String,dynamic> json = jsonDecode(response.body);

        loginModel.value.fromJson(json);

        return true;
      }


    return false;
  }


 Future logout() async{
   var headers = {
     'Authorization':
     'bearer ${loginModel.value.token?.accessToken}',
     // "x-localization": 'lang_code'.tr,
   };
   final response = await AppApiHandler.getData(url: AppUrls.logout,header: headers,);

   println(response.body);
   if(response.statusCode == 200){
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString(appStorageEmail, 'null');
     await prefs.setString(appStoragePassword, 'null');
     final String email = prefs.getString(appStorageEmail) ?? 'null';
     final String password = prefs.getString(appStoragePassword) ?? 'null';

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
    getMyLocation();
  }

  getMyLocation() async {
    position  = await _determinePosition();

  }
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}