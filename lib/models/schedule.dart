
import 'package:wassl/helpers/extensions/strings_extensions.dart';

class Schedule {
  int? id;
  int? employeeId;
  int? scheduleId;
  int? minuteTimeOut;
  int? minuteTimeIn;
  String? allowTimeOut;
  String? allowTimeIn;
  Info? info;

  Schedule();

  Schedule.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    employeeId = json['employee_id'];
    scheduleId = json['schedule_id'];
    minuteTimeOut = json['minute_time_out'];
    minuteTimeIn = json['minute_time_in'];
    allowTimeOut = json['allow_time_out'];
    allowTimeIn = json['allow_time_in'];
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }

  String get timeIn {
    return (info?.timeIn ?? '').formattedTime() ?? '---';
  }

  String get timeOut {
    return (info?.timeOut ?? '').formattedTime() ?? '---';
  }


}

class Info {
  int? id;
  int? companyId;
  int? type;
  String? slug;
  String? weekEndDays;
  String? timeIn;
  String? timeOut;

  Info(
      {this.id,
        this.companyId,
        this.type,
        this.slug,
        this.weekEndDays,
        this.timeIn,
        this.timeOut});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    type = json['type'];
    slug = json['slug'];
    weekEndDays = json['week_end_days'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
  }


}