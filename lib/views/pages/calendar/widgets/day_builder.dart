
import '../../../../getx_controllers/calendar/calendar_controller.dart';
import '../../../../helpers/constants/print_ln.dart';
import '../../../../models/attendance/month_attendance.dart';

Set<int> weekDays = {};
List<int> weekEnds = [];





bool checkDayAs(String type, DateTime day, CalendarViewModel controller) {


  final today = DateTime.tryParse(controller
      .attendanceOfMonth
      .value
      .attendancesOfMonth[(day.day - 1) ]
      .day ??
      '');

  return ((controller
              .attendanceOfMonth
              .value
              .attendancesOfMonth[(day.day - 1) ]
              .status ==
          type) &&
      (day.day == today?.day && day.month == today?.month && day.year == today?.year));
}
//
bool checkMissedDay(DateTime dateTime, CalendarViewModel controller) {


  final today = DateTime.tryParse(controller
      .attendanceOfMonth
      .value
      .attendancesOfMonth[(dateTime.day - 1) ]
      .day ??
      '');

  var missed = false;
  final List<Schedules>  schedules = controller.attendanceOfMonth.value.attendancesOfMonth[dateTime.day - 1].schedules;


    for(var sch in schedules){

      if(sch.attendance != null){

        missed = sch.attendance?.leaveTime.contains('--') ?? false;

        break;
      }
    }


  return (missed) &&
      (dateTime.day == today?.day && dateTime.month == today?.month && dateTime.year == today?.year);
}
//
// bool checkLateAttendance(DateTime dateTime, CalendarViewModel controller) {
//   return ((controller
//       .attendanceOfMonth
//       .value
//       .attendancesOfMonth[(dateTime.day - 1) %
//       controller.attendanceOfMonth.value.attendancesOfMonth.length]
//       .attendance
//       ?.first.leaveTime ==
//       null) &&
//       DateTime.tryParse(controller
//           .attendanceOfMonth
//           .value
//           .attendancesOfMonth[(dateTime.day - 1) %
//           controller.attendanceOfMonth.value.attendancesOfMonth
//               .length]
//           .day ??
//           '')
//           ?.month ==
//           dateTime.month);
// }
//
// bool checkEarlyLeave(DateTime dateTime, CalendarViewModel controller) {
//   return ((controller
//       .attendanceOfMonth
//       .value
//       .attendancesOfMonth[(dateTime.day - 1) %
//       controller.attendanceOfMonth.value.attendancesOfMonth.length]
//       .attendance
//       ?.first.leaveTime ==
//       null) &&
//       DateTime.tryParse(controller
//           .attendanceOfMonth
//           .value
//           .attendancesOfMonth[(dateTime.day - 1) %
//           controller.attendanceOfMonth.value.attendancesOfMonth
//               .length]
//           .day ??
//           '')
//           ?.month ==
//           dateTime.month);
// }


