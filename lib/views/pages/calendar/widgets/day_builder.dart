
import '../../../../getx_controllers/calendar/calendar_controller.dart';
import '../../../../helpers/constants/print_ln.dart';

Set<int> weekDays = {};
List<int> weekEnds = [];





// bool checkDayAs(String type, DateTime dateTime, CalendarViewModel controller) {
//
//   println(dateTime);
//
//   return ((controller
//               .attendanceOfMonth
//               .value
//               .attendancesOfMonth[(dateTime.day - 1) ]
//               .status ==
//           type) &&
//       DateTime.tryParse(controller
//                       .attendanceOfMonth
//                       .value
//                       .attendancesOfMonth[(dateTime.day - 1) ]
//                       .day ??
//                   '')
//               ?.month ==
//           dateTime.month);
// }
//
// bool checkMissedDay(DateTime dateTime, CalendarViewModel controller) {
//   return ((controller
//               .attendanceOfMonth
//               .value
//               .attendancesOfMonth[(dateTime.day - 1) %
//                   controller.attendanceOfMonth.value.attendancesOfMonth.length]
//               .attendance
//               .first.leaveTime ==
//           null) &&
//       DateTime.tryParse(controller
//                       .attendanceOfMonth
//                       .value
//                       .attendancesOfMonth[(dateTime.day - 1) %
//                           controller.attendanceOfMonth.value.attendancesOfMonth
//                               .length]
//                       .day ??
//                   '')
//               ?.month ==
//           dateTime.month);
// }
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


