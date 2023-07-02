import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';

import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';
import 'package:wassl/models/auth/attendance_checker.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../models/auth/holidays.dart';
import '../../models/events/events.dart';
import '../../web_services_helper/api.dart';
import '../calendar/calendar_controller.dart';
import 'package:timezone/standalone.dart' as tz;


class HomeController extends GetxController{

  final AppController appController = Get.find();

  var sendingAttendance = false.obs;


  var attendanceStatus = 1.obs;
  late AttendanceChecker attendanceChecker;
 final CalendarController calendarController = Get.find();
  var dt = DateTime.now().obs;
  var events = IncomingEvents().obs;
  // page :- apis retriever
 Future<String> registerAttendance({String? bearer}) async {




    sendingAttendance.value = true;
    var body = {
      'longitude':'${appController.position?.longitude}',
      'latitude':'${appController.position?.latitude}'
    };
    var headers = {
      'Authorization':
      'bearer ${bearer ?? appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };

    var url = '';
    if(attendanceStatus.value == 2){
      url = AppUrls.leaving;
    }else {
      url = AppUrls.attendance;

    }
    var listOfErrors = <String>[];
    listOfErrors.clear();
    listOfErrors.addAll(appController.listOfErrors);

    appController.listOfErrors.clear();
    appController.listOfErrors.addAll(listOfErrors);
    appController.listOfErrors.add('url: $url');
    appController.listOfErrors.add('body: $body');

    final response = await AppApiHandler.postData(url: url, body: body,header: headers);

    sendingAttendance.value = false;
    appController.listOfErrors.add('response.statusCode  ${response.statusCode }');
    appController.listOfErrors.add('response.body  ${response.body }');

    if(response.statusCode == 200){

      var json = jsonDecode(response.body);
      if(json['success'] == true) {
        attendanceStatus.value = attendanceStatus.value == 2 ? 3 : 2;
        calendarController.retrieveAttendanceData();
        if (attendanceStatus.value == 2) {
          return 'attendance_done_successfully'.tr;
        } else {
          return 'leaving_done_successfully'.tr;
        }
      }else{
        Future.error(json['message']);
      }

    }
    return Future.error('${response.body}\n${appController.position?.longitude},${appController.position?.latitude}');
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

   if(response.statusCode == 200){
     var json = jsonDecode(response.body);
     attendanceChecker = AttendanceChecker.fromJson(json);

     attendanceStatus.value = attendanceChecker.attendanceStatus ?? 0;
   }

  }



  /// page variables
  String get attendanceStatusValue{

    return attendanceStatus.value == 2 ? 'reg_leaving'.tr : attendanceStatus.value == 1 ?  'reg_attend'.tr : 'shift_done'.tr;
  }

  String get currentTime{
   return '${dt.value}'.formattedTimeFromDateTime();
    return '${hours}:${minutes} ${am_pm}';
  }


  String get hours {
    if(dt.value.hour == 0) return '12';

    if(dt.value.hour > 12) return '${dt.value.hour - 12}';
    return '0${dt.value.hour}';
  }
  String get minutes {
    return '${dt.value.minute}';
  }
  String get am_pm{
    return dt.value.hour > 11 ? 'pm'.tr :'am'.tr;
  }

  bool get isLocationDisabled {
   return appController.position == null;
  }


  //controller lifecycle
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // tz.timeZoneDatabase.locations.forEach((key, value) {
    //   println('key $key, location: ${value.name}');
    // });
    final detroit = tz.getLocation('Asia/Riyadh');
    // dt.value = tz.TZDateTime.from(dt.value, detroit);
    checkForAttendance();
    Timer.periodic(Duration(seconds: 1), (timer) {
      dt.value = tz.TZDateTime.from(DateTime.now(), detroit);
    });
   appController.determinePosition();
  }

}