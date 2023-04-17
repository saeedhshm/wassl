import 'package:get/get.dart';

import '../constants/print_ln.dart';

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
// ···
}

extension FormatedDateTimeExtension on String {
  String formattedTime() {
    var myTime = '----';
    var timeSpieces = this.split(':');
    if (timeSpieces.length > 1) {
      myTime = _formattedTime(timeSpieces);
    }
    return myTime;
  }

  String get timeFromTZone{
    var myTime = '----';
    var splittedArray = split('T');
    var timeList = splittedArray[1].split(':');
    int hours = int.tryParse(timeList[0]) ?? 0;
    int minutes = int.tryParse(timeList[1]) ?? 0;
    var pm_am = hours > 12 ? 'pm'.tr : 'am'.tr;
    hours = hours > 12 ? hours - 12 : hours;
    myTime = hours == 0
        ? '12'
        : hours < 10
        ? '0$hours'
        : '$hours';
    myTime += minutes < 10 ? ':0$minutes' : ':$minutes';
    myTime = '$myTime $pm_am';
    return myTime;
  }

  String get dateFromTZone{
    var myDate = '';

    var splittedArray = split('T');
    var dateList = splittedArray[0].split('-');
    // println(timeList);
    // '5/10/2022'
    myDate = '${dateList[2]}/${dateList[1]}/${dateList[0]}';
    return myDate;
  }

  String formattedTimeFromDateTime() {
    var myTime = '----';
    var splitedDate = split(' ');
    var timeSpieces = splitedDate[1].split(':');

    if (timeSpieces.length > 1) {
      myTime = _formattedTime(timeSpieces);
    }
    return myTime;
  }

  String get timeFromTimeSelection {
    var time = '-----';
    if (isNotEmpty) {
      var timeList = this.split(':');
      int hours = int.tryParse(timeList[0]) ?? 0;
      int minutes = int.tryParse(timeList[1]) ?? 0;
      var pm_am = hours > 12 ? 'pm'.tr : 'am'.tr;
      hours = hours > 12 ? hours - 12 : hours;
      time = hours == 0
          ? '12'
          : hours < 10
              ? '0$hours'
              : '$hours';
      time += minutes < 10 ? ':0$minutes' : ':$minutes';
      time = '$time $pm_am';
    }

    return time;
  }

  int get hourOfTimeSelection{
    int h = 0;
    if (isNotEmpty) {
      var timeList = split(':');
      h = int.tryParse(timeList[0]) ?? 0;
    }
    return h;
  }
  int get minuteOfTimeSelection{
    int m = 0;
    if (isNotEmpty) {
      var timeList = split(':');
      m = int.tryParse(timeList[1]) ?? 0;
    }
    return m;
  }
}

String _formattedTime(List<String> timeSpieces) {
  int hours = int.tryParse(timeSpieces[0]) ?? 0;
  int minuts = int.tryParse(timeSpieces[1]) ?? 0;
  String status = '';
  if (hours > 12) {
    hours = hours - 12;
    return '${hours == 0 ? 12 : hours < 10 ? '0$hours' : hours}:${minuts == 0 ? '00' : minuts < 10 ? '0$minuts' : minuts} ${'pm'.tr}';
  } else {
    return '${hours == 0 ? 12 : hours < 10 ? '0$hours' : hours}:${minuts == 0 ? '00' : minuts} ${'am'.tr}';
  }
}
