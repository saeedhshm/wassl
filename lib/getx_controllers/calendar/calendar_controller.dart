import 'dart:convert';
import 'package:get/get.dart';
import 'package:wassl/controllers/calendar_controller.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import '../../models/attendance/month_attendance.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class CalendarViewModel extends GetxController {
  final AppController appController = Get.find();

  late CalendarController _calendarController = CalendarController(appController.appHeader);

  var loading = false.obs;
  var attendanceOfMonth = MonthAttendance().obs;
  var selectedDay = MonthDay().obs;
  late DateTime dateTime;
  var foCusedDate = DateTime.now().obs;

  var noInternetAvailable = ''.obs;
  var noDataAttendanceAvailable = ''.obs;

  Future<void> _checkForMonthAttendance() async {


    attendanceOfMonth.value.attendancesOfMonth.clear();
    _calendarController.url =
        '${AppUrls.monthlyAttendance}?month=${dateTime.month}&year=${dateTime.year}';

    var monthAttendance = await _calendarController.checkForMonthAttendance();

    if(monthAttendance != null){
      attendanceOfMonth.value = monthAttendance;

      setSelectedDate(DateTime.now());
    }else{
      throw NoDataAvailableException();
    }

  }



  void retrieveAttendanceData() async {
    try {
      loading.value = true;
      await _checkForMonthAttendance();
      noInternetAvailable.value = '';
    } on NoInternetException catch (e) {
      noInternetAvailable.value = e.errorMessage;
    } on NoDataAvailableException catch (e) {
      noDataAttendanceAvailable.value = 'noDataAttendanceAvailable';
    } finally {
      loading.value = false;
    }
  }




  String get countWorkDaysAbsent {
    return attendanceOfMonth.value.countWorkDaysAbsent.toString();
  }

  String get lateAttendanceCount {
    return attendanceOfMonth.value.lateAttendance.toString();
  }

  String get earlyLeaveCount {
    return attendanceOfMonth.value.earlyLeaveCount.toString();
  }

  String get missedRecordsCount {
    return attendanceOfMonth.value.missedRecords.toString();
  }

  String get workShiftStartingTime {
    return appController.loginModel.value.timeIn;
  }

  String get workShiftEndingTime {
    return appController.loginModel.value.timeOut;
  }

  String get currentSelectedDate {
    return selectedDay.value.day ?? '';
  }

  String get selectedDateStatus {
    return selectedDay.value.status.tr;
  }

  String get selectedDateAttendanceTime {
    return selectedDay.value.attendanceTime;
  }

  String get selectedDateLeaveTime {
    return selectedDay.value.leaveTime;
  }

  bool get noLeavingRegistered {
    return selectedDay.value.attendanceDay?.leaveTime == null;
  }



  setSelectedDate(DateTime dateTime) {
    for (MonthDay day in attendanceOfMonth.value.attendancesOfMonth) {
      if (DateTime.tryParse(day.day ?? '') ==
          DateTime(dateTime.year, dateTime.month, dateTime.day)) {
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
}
