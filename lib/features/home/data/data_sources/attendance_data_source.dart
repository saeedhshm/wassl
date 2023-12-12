import '../../../../helpers/exceptions/internet_api_exceptions.dart';
import '../../../../web_services_helper/api.dart';
import '../../../../web_services_helper/urls.dart';
import '../models/attendance_check.dart';
import '../models/attendance_checks.dart';

abstract class AttendanceDataSource {
  Future<List<AttendanceCheck>> checkAttendance(Map<String, String> header);
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
}
