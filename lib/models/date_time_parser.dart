import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../helpers/constants/print_ln.dart';
class DateTimeParser{
  final DateTime _dateTime;

  DateTimeParser(this._dateTime);

  DateTime get dateTime{
    return _dateTime;
  }

  String get date{
    var dateFormatter = DateFormat("yyyy-MM-dd");
    var dateFromDateTime = dateFormatter.format(_dateTime);
    return dateFromDateTime;
  }

  String get timeIn24{
    var dateFormatter = DateFormat("HH:mm:ss");
    var dateFromDateTime = dateFormatter.format(_dateTime);
    return dateFromDateTime;
  }

  String get timeIn12{
    var dateFormatter = DateFormat("hh:mm a");
    var dateFromDateTime = dateFormatter.format(_dateTime);
    var timePieces = dateFromDateTime.split(' ');
    if (timePieces.length > 1) {
      return '${timePieces.first} ${timePieces.last.tr}';
    }
    return dateFromDateTime;
  }

  int get hour{
    return _dateTime.hour;
  }

  String get amPm{
    var dateFormatter = DateFormat("a");
    var dateFromDateTime = dateFormatter.format(_dateTime);
    return dateFromDateTime;
  }

  int get minute{
    return _dateTime.minute;
  }

}