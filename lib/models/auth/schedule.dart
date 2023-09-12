import 'package:wassl/helpers/extensions/strings_extensions.dart';

import 'info.dart';

class Schedule {
  int? id;
  int? employeeId;
  int? scheduleId;
  int? minuteTimeOut;
  int? minuteTimeIn;
  String? allowTimeOut;
  String? allowTimeIn;
  Info? info;

  Schedule(
      {this.id,
        this.employeeId,
        this.scheduleId,
        this.minuteTimeOut,
        this.minuteTimeIn,
        this.allowTimeOut,
        this.allowTimeIn,
        this.info});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    scheduleId = json['schedule_id'];
    minuteTimeOut = json['minute_time_out'];
    minuteTimeIn = json['minute_time_in'];
    allowTimeOut = json['allow_time_out'] ?? '00:40:00';
    allowTimeIn = json['allow_time_in'];
    info = json['info'] != null ?  Info.fromJson(json['info']) : null;
  }

  DateTime get empTimeIn{
    return (info?.timeIn ?? '').exactDateTimeFromGivenHours!;
  }

  DateTime get empTimeOut{
    return (info?.timeOut ?? '').exactDateTimeFromGivenHours!;
  }

}
