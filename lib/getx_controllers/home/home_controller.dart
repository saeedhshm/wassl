import 'dart:async';

import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';

import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../web_services_helper/api.dart';

class HomeController extends GetxController{

  final AppController appController = Get.find();

  // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);var
  var sendingAttendance = false.obs;
  var isAttended = false.obs;

  var dt = DateTime.now().obs;

  registerAttendance() async {
    sendingAttendance.value = true;
    var body = {
      'longitude':'${appController.position.longitude}',
      'latitude':'${appController.position.latitude}'
    };
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };
    final response = await AppApiHandler.sendData(url: AppUrls.attendance, body: body,header: headers);
    sendingAttendance.value = false;
    isAttended.value = true;
    println(body);
    println(response.statusCode);
    println(response.body);
  }

  registerLeaving() async {
    sendingAttendance.value = true;

    var body = {
      'longitude':'${appController.position.longitude}',
      'latitude':'${appController.position.latitude}'
    };
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };
    final response = await AppApiHandler.sendData(url: AppUrls.leaving, body: body,header: headers);
    sendingAttendance.value = false;
    isAttended.value = false;
    println(body);
    println(response.statusCode);
    println(response.body);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Timer.periodic(Duration(seconds: 1), (timer) {
      dt.value = DateTime.now();
    });

  }

  String get hours {

    if(dt.value.hour > 12)
      return '${dt.value.hour - 12}';
    return '${dt.value.hour}';
  }
  String get minutes {
    return '${dt.value.minute}';
  }
  String get am_pm{
    return dt.value.hour > 11 ? 'pm'.tr :'am'.tr;
  }
}