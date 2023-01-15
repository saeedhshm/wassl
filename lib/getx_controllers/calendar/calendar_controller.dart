import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/constants/print_ln.dart';
import '../../models/attendance/month_attendance.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class CalendarController extends GetxController{

  final AppController appController = Get.find();

  var loading = false.obs;
  var attendanceOfMonth = MonthAttendance().obs;
  var selectedDay = MonthDay().obs;
  late DateTime dateTime;

 Future<void> checkForMonthAttendance() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };

    println('sdifoisdhfiosdf>>>>>>>>> checkForMonthAttendance');


    loading.value = true;
    attendanceOfMonth.value.attendancesOfMonth.clear();
    final url = '${AppUrls.monthlyAttendance}?month=${dateTime.month}&year=${dateTime.year}';
    // const url = AppUrls.monthlyAttendance;
    final response = await AppApiHandler.getData(url: url,header: headers,);
    println('=-=-=-=-=-=-=-==-=-=-???? CalendarController -----');
    println(url);
    // println(headers);
    println(response.statusCode);
    // println(response.body);
    println('=-=-=-=-=-=-=-==-=-=-???? CalendarController -----');
    if(response.statusCode == 200){
      var json = jsonDecode(response.body);

      attendanceOfMonth.value = MonthAttendance.fromJson(json);
      println('=-=-=-=-=-=-=-==-=-=-???? CalendarController ----- ${attendanceOfMonth.value.attendancesOfMonth.length}');

      for(MonthDay day in attendanceOfMonth.value.attendancesOfMonth ){
        println(day.day);
        println(day.status);
        setSelectedDate(DateTime.now());
      }

      loading.value = false;
    }
  }



setSelectedDate(DateTime dateTime){
  for(MonthDay day in attendanceOfMonth.value.attendancesOfMonth){

    if(DateTime.tryParse(day.day ?? '') == DateTime(dateTime.year,dateTime.month,dateTime.day)){
      selectedDay.value = day;
    }
  }
}


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dateTime = DateTime(DateTime.now().year,2);
    println('-===-=-->>>> init date = $dateTime');
    checkForMonthAttendance();
  }


}