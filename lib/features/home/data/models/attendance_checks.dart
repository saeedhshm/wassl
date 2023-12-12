import 'dart:convert';

import 'attendance_check.dart';

class AttendanceChecks {
  static List<AttendanceCheck> getAttendanceCheckList(String responseBody) {
    List<AttendanceCheck> checkList = [];
    try {
      var json = jsonDecode(responseBody) as List;

      checkList = json.map((e) => AttendanceCheck.fromJson(e)).toList();
    } catch (e) {
      var json = jsonDecode(responseBody);
      checkList.add(AttendanceCheck.fromJson(json));
    }
    checkList.sort((a, b) {
      return a.empTimeIn.compareTo(b.empTimeIn);
    });

    return checkList;
  }
}
