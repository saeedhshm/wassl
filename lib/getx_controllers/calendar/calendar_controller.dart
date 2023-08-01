import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';

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
  var foCusedDate = DateTime.now().obs;

  var noInternetAvailable = ''.obs;
  var noDataAttendanceAvailable = ''.obs;

 Future<void> _checkForMonthAttendance() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };


    loading.value = true;
    attendanceOfMonth.value.attendancesOfMonth.clear();
    final url = '${AppUrls.monthlyAttendance}?month=${dateTime.month}&year=${dateTime.year}';

    println(url);

    final response = await AppApiHandler.getData(url: url,header: headers,);


    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
    if(response.statusCode == 200){
      var json = jsonDecode(response.body);

      // println(json);
      attendanceOfMonth.value = MonthAttendance.fromJson(json);

        setSelectedDate(DateTime.now());
        update();


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
    dateTime = DateTime.now();
   retrieveAttendanceData();

  }

  void retrieveAttendanceData() async{
    try{

      await _checkForMonthAttendance();
      noInternetAvailable.value = '';
    }on NoInternetException catch(e){
      noInternetAvailable.value = e.errorMessage;
    }on NoDataAvailableException catch(e){
      noDataAttendanceAvailable.value = 'noDataAttendanceAvailable';
    }
    finally{
      loading.value = false;
    }
  }

}