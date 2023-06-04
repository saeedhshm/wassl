import 'info.dart';

class Schedule {
  int? id;
  int? employeeId;
  int? scheduleId;
  Info? info;

  Schedule({this.id, this.employeeId, this.scheduleId, this.info});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    scheduleId = json['schedule_id'];
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['schedule_id'] = this.scheduleId;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}