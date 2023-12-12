import '../../../../helpers/constants/print_ln.dart';
import 'attendance_check.dart';

class CurrentShiftRetriever {
  static AttendanceCheck? retrieveCurrentShift(
      List<AttendanceCheck> checkList) {
    AttendanceCheck? currentShift;

    currentShift = checkList.first;
    currentShift.shiftIndex = 0;

    if (checkList.length > 1) {
      if (DateTime.now().isAfter(currentShift.empAllowTimeOut)) {
        currentShift = checkList.last;
        currentShift.shiftIndex = 1;
      }
      currentShift.haseTowShifts = true;
    }
    println('=-=--=-=- ${currentShift.haseTowShifts}');
    return currentShift;
  }
}
