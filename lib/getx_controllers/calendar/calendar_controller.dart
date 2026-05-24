import 'package:get/get.dart';
import 'package:wassl/controllers/calendar_controller.dart';
import 'package:wassl/helpers/exceptions/internet_api_exceptions.dart';

import '../../models/attendance/month_attendance.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class CalendarViewModel extends GetxController {
  final AppController appController = Get.find();

  late final CalendarController _calendarController =
      CalendarController(appController.appHeader);

  var loading = false.obs;
  var attendanceOfMonth = MonthAttendance().obs;
  var selectedDay = AttendancesOfMonth().obs;
  late DateTime dateTime;
  var foCusedDate = DateTime.now().obs;

  var noInternetAvailable = ''.obs;
  var noDataAttendanceAvailable = ''.obs;

  Future<void> _checkForMonthAttendance() async {
    attendanceOfMonth.value.attendancesOfMonth.clear();
    _calendarController.url =
        '${AppUrls.monthlyAttendance}?month=${dateTime.month}&year=${dateTime.year}';

    var monthAttendance = await _calendarController.checkForMonthAttendance();

    if (monthAttendance != null) {
      attendanceOfMonth.value = monthAttendance;

      setSelectedDate(DateTime.now());
    } else {
      throw NoDataAvailableException();
    }
  }

  void retrieveAttendanceData() async {
    try {
      loading.value = true;
      if (appController.useMocks) {
        await Future.delayed(const Duration(milliseconds: 500));
        final now = DateTime.now();
        final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
        final attendances = <Map<String, dynamic>>[];
        for (int i = 1; i <= daysInMonth; i++) {
          final day = DateTime(now.year, now.month, i);
          final isWeekend = day.weekday == DateTime.friday || day.weekday == DateTime.saturday;
          attendances.add({
            'day': day.toIso8601String(),
            'status': isWeekend
                ? 'weekEnd'
                : (i <= 22 ? 'attend' : 'absent'),
            'schedules': isWeekend
                ? []
                : [
                    {
                      'attendance_status': i <= 22 ? 3 : 1,
                      'attendance': i <= 22
                          ? {
                              'id': i,
                              'attendance_time': '${day.toIso8601String().split('T')[0]} 08:00:00',
                              'leave_time': '${day.toIso8601String().split('T')[0]} 17:00:00',
                            }
                          : null,
                      'schedule': {
                        'id': 1,
                        'time_in': '08:00:00',
                        'time_out': '17:00:00',
                      },
                    },
                  ],
          });
        }
        attendanceOfMonth.value = MonthAttendance.fromJson({
          'countWorkDaysAbsent': daysInMonth - 22,
          'countWorkDaysAttend': 22,
          'earlyLeaveDaysCount': 1,
          'lateAttendDaysCount': 2,
          'missingLeaveDaysCount': 0,
          'totalAttendances': {
            'total': '176:00:00',
            'total_attendance_late_time': '00:45:00',
            'countWorkDays': 22,
            'countWorkHour': 176,
          },
          'attendancesOfMonth': attendances,
        });
        setSelectedDate(DateTime.now());
      } else {
        await _checkForMonthAttendance();
      }
      noInternetAvailable.value = '';
    } on NoInternetException catch (e) {
      noInternetAvailable.value = e.errorMessage;
    } on NoDataAvailableException {
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

  // String get workShiftStartingTime {
  //   return appController.loginModel.value.timeIn;
  // }
  //
  // String get workShiftEndingTime {
  //   return appController.loginModel.value.timeOut;
  // }

  List<Schedules> get shiftsSchedules {
    return selectedDay.value.schedules;
  }

  String get currentSelectedDate {
    return selectedDay.value.day ?? '';
  }

  String get selectedDateStatus {
    return selectedDay.value.status.tr;
  }

  // String get selectedDateAttendanceTime {
  //   return selectedDay.value.attendanceTime;
  // }

  // String get selectedDateLeaveTime {
  //   return selectedDay.value.attendance.;
  // }

  // bool get noLeavingRegistered {
  //   return  selectedDay.value.attendance?.leaveTime == null;
  // }

  setSelectedDate(DateTime dateTime) {
    for (AttendancesOfMonth dayInMonth
        in attendanceOfMonth.value.attendancesOfMonth) {
      if (DateTime.tryParse(dayInMonth.day ?? '') ==
          DateTime(dateTime.year, dateTime.month, dateTime.day)) {
        selectedDay.value = dayInMonth;
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
