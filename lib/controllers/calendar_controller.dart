import 'dart:convert';

import '../helpers/exceptions/internet_api_exceptions.dart';
import '../models/attendance/month_attendance.dart';
import '../web_services_helper/api.dart';

class CalendarController {
  String? url;
  Map<String, String> header;
  CalendarController(this.header);
  Future<MonthAttendance?> checkForMonthAttendance() async {
    //
    final response = await AppApiHandler.getData(
      url: url!,
      header: header,
    );
    //
    //

    if (response.statusCode != 200) {
      throw NoDataAvailableException();
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      // println(json);
      return MonthAttendance.fromJson(json);
    }

    return null;
  }
}

//almarsad@gmail.com 123456789
