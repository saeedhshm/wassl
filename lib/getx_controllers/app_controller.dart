import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import 'package:wassl/helpers/exceptions/passwords_exceptions.dart';
import 'package:wassl/models/auth/LoginModel.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../helpers/constants/string_constants.dart';
import '../helpers/location/position.dart';
import '../models/auth/holidays.dart';

class AppController extends GetxController {
  var loading = false.obs;

  var gettingHolidays = false.obs;
  var holidaysBalance = Holidays().obs;

  String testingUserName = '';

  // late HuaweiLocationServices huaweiLocationServices;

  var listOfErrors = <String>[].obs;

  var canUpdate = false;
  var appURL = '';
  late List<String> langs;

  String? fCMToken;

  var countryCode = ''.obs;

  var loginModel = LoginModel().obs;
  var rememberMe = true;

  UserPosition? position;

  var deployingForApple = false;

  final _checker = AppVersionChecker();

  getHolidaysData() async {
    var url = AppUrls.vacationsApi;
    var headers = {
      'Authorization': 'bearer ${loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };
    gettingHolidays.value = true;
    var response = await AppApiHandler.getData(url: url, header: headers);
    gettingHolidays.value = false;

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      holidaysBalance.value = Holidays.fromJson(json);
    }
  }

  Future<void> login({required String email, required String password}) async {
    loading.value = true;
    final response = await AppApiHandler.postData(
        url: AppUrls.login, body: {'email': email, 'password': password});
    // int statusCode = response.statusCode;
    // println(AppUrls.login);
    // println(response.statusCode);
    // println(response.body);

    loading.value = false;
    if (response.statusCode == 200) {
      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(appStorageEmail, email);
        await prefs.setString(appStoragePassword, password);
      }
      Map<String, dynamic> json = jsonDecode(response.body);

      loginModel.value.fromJson(json);
      if (fCMToken != null) {
        final fcmResponse = await AppApiHandler.postData(
            url: AppUrls.updateToken,
            header: appHeader,
            body: {
              'token': fCMToken,
            });
      }
    } else {
      throw UserNotFoundException();
    }
  }

  Map<String, String> get appHeader {
    return {
      'Authorization': 'bearer ${loginModel.value.token?.accessToken}',
      "x-localization": 'lang_code'.tr,
    };
  }

  Future<String> changeMyPassword(
      {required String currentPassword,
      required String newPassword,
      required String confirmPassword}) async {
    final prefs = await SharedPreferences.getInstance();
    String oldPassword = prefs.getString(appStoragePassword) ?? '';

    if (oldPassword != currentPassword) {
      throw CurrentPasswordException();
    }

    if (newPassword.length < 6) {
      throw PasswordLengthException();
    }

    if (newPassword != confirmPassword) {
      throw NewPassConfirmedPassException();
    }

    loading.value = true;
    var headers = {
      'Authorization': 'bearer ${loginModel.value.token?.accessToken}',
      "x-localization": 'lang_code'.tr,
    };
    final response = await AppApiHandler.postData(
        url: AppUrls.changePassword,
        header: headers,
        body: {
          'currentPassword': currentPassword,
          'password': newPassword,
          'confirmPassword': newPassword
        });

    loading.value = false;
    if (response.statusCode != 200) {
      throw ChangePasswordException();
    }
    if (response.statusCode == 200) {
      await prefs.setString(appStoragePassword, newPassword);
      return 'password_changed';
    }
    return Future.error('password_didnt_change');
  }

  Future logout() async {
    var headers = {
      'Authorization': 'bearer ${loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };
    loading.value = true;
    final response = await AppApiHandler.getData(
      url: AppUrls.logout,
      header: headers,
    );

    loading.value = false;
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(appStorageEmail, 'null');
      await prefs.setString(appStoragePassword, 'null');

      loginModel.value = LoginModel();
    }
  }

  Future<Map<String, String>> retrieveUserAuth() async {
    var userCreds = <String, String>{};
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString(appStorageEmail) ?? 'null';
    final String password = prefs.getString(appStoragePassword) ?? 'null';

    userCreds.addAll({'email': email, 'password': password});
    return userCreds;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // huaweiLocationServices = HuaweiLocationServices();
    await getLanguage();
    checkVersion();
    // initPlatformState();
  }

  void checkVersion() async {
    var value = await _checker.checkUpdate();
    // println('return true if update is available ${value.canUpdate}'); //return true if update is available
    // println('return current app version ${value.currentVersion}'); //return current app version
    // println('return the new app version ${value.newVersion}'); //return the new app version
    // println('return the app url ${value.appURL}'); //return the app url
    // println('return error message if found else it will return null ${value.errorMessage}'); //return error message if found else it will return null

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
  Future<void> determdinePosition() async {}

  bool get isHolidayDay {
    var weekEnds = (loginModel.value.user?.schedule?.info?.weekEndDays ?? '')
        .split(',')
        .map((e) => int.tryParse(e) ?? 0)
        .toList(); //(loginModel.value.user?.schedule?.info?.weekEndDays ?? '').split(',');
    var today = DateTime.now().weekday;
    for (int i in weekEnds) {
      if (today == i) return true;
    }

    return false;
  }

  bool get isFingerPrintExempt {
    return (loginModel.value.user?.isExemptFingerprinting ?? 0) == 1;
  }

  setLanguage(String langCode, String countryCode) async {
    Get.updateLocale(Locale(langCode, countryCode));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('language', [langCode, countryCode]);
  }

  getLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final langCode = '${Get.deviceLocale?.languageCode}' == 'ar' ? 'ar' : 'en';
    langs = preferences.getStringList('language') ??
        [langCode, '${Get.deviceLocale?.countryCode}'];
  }
}
