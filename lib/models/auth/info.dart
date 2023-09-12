import 'package:wassl/helpers/extensions/strings_extensions.dart';

class Info {
  int? id;
  int? companyId;
  int? type;
  String? slug;
  String? weekEndDays;
  String? timeIn;
  String? timeOut;

  Info();

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    type = json['type'];
    slug = json['slug'];
    weekEndDays = json['week_end_days'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
  }

  String get timeInEx{
    // var time = '----';
    // if(_timeIn != null){
    //   time =  _timeIn?.split(' ')[1] ?? '----';
    // }
    return timeIn?.formattedTime() ?? '---';
  }
  String get timeOutEx{
    // var time = '----';
    // if(_timeOut != null){
    //   time =  _timeOut?.split(' ')[1] ?? '----';
    // }
    return timeOut?.formattedTime() ?? '---';
  }
}

