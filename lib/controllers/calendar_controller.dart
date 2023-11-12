import 'dart:convert';

import 'package:wassl/helpers/constants/print_ln.dart';

import '../helpers/exceptions/no_internet.dart';
import '../models/attendance/month_attendance.dart';
import '../web_services_helper/api.dart';
import '../web_services_helper/urls.dart';

class CalendarController{

  String? url;
  Map<String,String> header;
  CalendarController(this.header);
  Future<MonthAttendance?> checkForMonthAttendance() async {

    //
    final response = await AppApiHandler.getData(url: url!,header: header,);
    //
    //
    println(url);
    println(response.statusCode);
    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
    if(response.statusCode == 200){
      var json = jsonDecode(response.body);

      // println(json);
      return MonthAttendance.fromJson(json);
    }

    return null;
  }
}

//almarsad@gmail.com 123456789
