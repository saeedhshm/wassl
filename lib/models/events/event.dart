import 'package:get/get.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';

// {this.id,
// this.startDate,
// this.endDate,
// this.startTime,
// this.endTime,
// this.details,
// this.title,
// this.location});

class IncomingEvent {
  int? _id;
  String? _title;
  String? _description;
  int? _status;
  String? _startDate;
  String? _endDate;
  String? _createdAt;
  String? _updatedAt;
  String? _location;
  Pivot? _pivot;

      // .formattedTimeFromDateTime()

  String get startTime => _startDate?.timeFromTZone ?? '';
  String get endTime => _startDate?.timeFromTZone ?? '';


  int get id => _id ?? 0;

  String get title => _title ?? '';

  String get details => _description ?? '';

  int get status => _status ?? 0;

  String get startDate => _startDate?.dateFromTZone ?? '';

  String get endDate => _endDate?.dateFromTZone ?? '';

  String get location => _location ?? 'not_specified'.tr;

  Pivot? get pivot => _pivot;


  IncomingEvent.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _status = json['status'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _location = json['location'];
    _pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

}

class Pivot {
  int? _companyEmployeesId;
  int? _meetingId;


  int? get companyEmployeesId => _companyEmployeesId;



  int? get meetingId => _meetingId;


  Pivot.fromJson(Map<String, dynamic> json) {
    _companyEmployeesId = json['company_employees_id'];
    _meetingId = json['meeting_id'];
  }

}
