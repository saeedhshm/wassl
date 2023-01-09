import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';

import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/auth/attendance_checker.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../web_services_helper/api.dart';

class HomeController extends GetxController{

  final AppController appController = Get.find();

  var sendingAttendance = false.obs;
  var isAttended = false.obs;
  late AttendanceChecker attendanceChecker;

  var dt = DateTime.now().obs;

  // page :- apis retriever
 Future<bool> registerAttendance() async {
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

    var url = '';
    if(!isAttended.value){
      url = AppUrls.attendance;
    }else {
      url = AppUrls.leaving;
    }
    println(url);
    final response = await AppApiHandler.sendData(url: url, body: body,header: headers);
    sendingAttendance.value = false;

    if(response.statusCode == 200){
      isAttended.value = !isAttended.value;
      return true;
    }
    return false;
  }


  checkForAttendance() async {
   var url = AppUrls.attendanceCheck;
   var headers = {
     'Authorization':
     'bearer ${appController.loginModel.value.token?.accessToken}',
     // "x-localization": 'lang_code'.tr,
   };
   sendingAttendance.value = true;
   var response = await AppApiHandler.getData(url: url, header: headers);
   sendingAttendance.value = false;
   println('=-=-=-=-=-=-=-==-=-=-???? checkForAttendance -----');
   println(response.statusCode);
   println(response.body);
   println('=-=-=-=-=-=-=-==-=-=-???? checkForAttendance -----');
   if(response.statusCode == 200){
     var json = jsonDecode(response.body);
     attendanceChecker = AttendanceChecker.fromJson(json);

     println(attendanceChecker.attendanceStatus);
     println(attendanceChecker.message);
     isAttended.value = attendanceChecker.attendanceStatus == 2;
   }

  }

  /// page variables
  String get attendanceStatus{
    return isAttended.value ? 'reg_leaving'.tr : 'reg_attend'.tr ;
  }

  String get currentTime{
    return '${hours}:${minutes} ${am_pm}';
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


  //controller lifecycle
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkForAttendance();
    Timer.periodic(Duration(seconds: 1), (timer) {
      dt.value = DateTime.now();
    });

  }

}