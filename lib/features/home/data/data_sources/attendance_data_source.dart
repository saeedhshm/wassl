import 'dart:convert';

import 'package:wassl/helpers/constants/print_ln.dart';

import '../../../../helpers/exceptions/internet_api_exceptions.dart';
import '../../../../web_services_helper/api.dart';
import '../../../../web_services_helper/urls.dart';
import '../models/attendance_check.dart';
import '../models/attendance_checks.dart';

abstract class AttendanceDataSource {
  Future<List<AttendanceCheck>> checkAttendance(Map<String, String> header);
  Future<void> registerAttendanceLeave(
      {required String url,
      required Map<String, dynamic> body,
      required Map<String, String> header});
  // Future<>
}

class AttendanceDataSourceImpl extends AttendanceDataSource {
  @override
  Future<List<AttendanceCheck>> checkAttendance(
      Map<String, String> header) async {
    var url = AppUrls.attendanceCheck;

    var response = await AppApiHandler.getData(url: url, header: header);
    if (response.statusCode == 200) {
      var responseBody = response.body;
      return AttendanceChecks.getAttendanceCheckList(responseBody);
    } else {
      throw NoDataAvailableException();
    }
  }

  @override
  Future<void> registerAttendanceLeave(
      {required String url,
      required Map<String, dynamic> body,
      required Map<String, String> header}) async {
    try {
      final response =
          await AppApiHandler.postData(url: url, body: body, header: header);
      // println(url);

      // println(response.body);
      var json = jsonDecode(response.body);
      println(json);
      if (response.statusCode == 200) {
        if (json['success'] != true) {
          throw UnknownException();
        }
      }
      if (response.statusCode != 200) {
        throw UnknownException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
