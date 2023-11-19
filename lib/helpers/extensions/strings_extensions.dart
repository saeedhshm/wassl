import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/date_time_parser.dart';

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
// ···

  String get replaceToArabicNumbers {
    // if(Get.locale?.languageCode == 'ar'){
      return replaceAll('1', '١')
          .replaceAll('2', '٢')
          .replaceAll('3', '٣')
          .replaceAll('4', '٤')
          .replaceAll('5', '٥')
          .replaceAll('6', '٦')
          .replaceAll('7', '٧')
          .replaceAll('8', '٨')
          .replaceAll('9', '٩')
          .replaceAll('0', '٠');
    // }
    // return 'this';
  }
}

extension FormatedDateTimeExtension on String {

  ///this function take time in this
  ///format 16:00:00 in 24 hours
  ///will return String time in 12 hours
  ///^([0-9]{2}):([0-5][0-9]):([0-5][0-9])$
  ///01:55:30
  String? formattedTime() {

    String? myTime;

    try{
      DateFormat dateFormatOf24Hours = DateFormat("HH:mm:ss");
      var timeIn24 = dateFormatOf24Hours.parse(this);
      myTime = getTimeFormatOf12hours(of: timeIn24);
    }catch(e){
     // println(e,'time exception');
    }

    return myTime;
  }

  DateTimeParser? get dateTimeParser{

    String dateFormat = '';
    String givenDate = this;

    //2023-09-10T07:56:52.000000Z
     if(RegExp(r"\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d",).hasMatch(this)){

    givenDate = split('.')[0].replaceAll('T', ' ');
    dateFormat = 'yyyy-MM-dd HH:mm:ss';

    }

    //2023-09-11 23:08:39
    else if(RegExp(r"\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}",).hasMatch(this)){

    dateFormat = 'yyyy-MM-dd HH:mm:ss';
    }

    ///01:55:30
    else if(RegExp(r"^\d{2}:\d{2}:\d{2}",).hasMatch(this)){

      dateFormat = 'HH:mm:ss';
    }

    // /2003-12-29
    else if(RegExp(r"^\d\d\d\d-\d\d-\d\d",).hasMatch(this)){
       dateFormat = 'yyyy-MM-dd';
    }



    // println(givenDate,this);
    try{
      DateFormat dateFormatOf24Hours = DateFormat(dateFormat);
      var timeIn24 = dateFormatOf24Hours.parse(givenDate);
      return DateTimeParser(timeIn24);
    }catch(e){
      // println(e,dateFormat);
    }

    return null;
  }

  DateTime? get exactDateTimeFromGivenHours{
    DateFormat format = DateFormat("HH:mm:ss");
    DateTime? exactTime;
    try{
      exactTime = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,format.parse(this).hour,format.parse(this).minute);
    }catch(e){
      // println(e.toString());
    }
    return exactTime;
  }

  String get timeFromTZone{


    var myTime = '----';
    var splittedArray = split('T');
    var timeList = splittedArray[1].split(':');
    int hours = int.tryParse(timeList[0]) ?? 0;
    int minutes = int.tryParse(timeList[1]) ?? 0;
    var pmAm = hours > 12 ? 'pm'.tr : 'am'.tr;
    hours = hours > 12 ? hours - 12 : hours;
    myTime = hours == 0
        ? '12'
        : hours < 10
        ? '0$hours'
        : '$hours';
    myTime += minutes < 10 ? ':0$minutes' : ':$minutes';
    myTime = '$myTime $pmAm';
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


  String get timeFromTimeSelection {


    var time = '-----';
    if (isNotEmpty) {
      var timeList = split(':');
      int hours = int.tryParse(timeList[0]) ?? 0;
      int minutes = int.tryParse(timeList[1]) ?? 0;
      var pmAm = hours > 12 ? 'pm'.tr : 'am'.tr;
      hours = hours > 12 ? hours - 12 : hours;
      time = hours == 0
          ? '12'
          : hours < 10
              ? '0$hours'
              : '$hours';
      time += minutes < 10 ? ':0$minutes' : ':$minutes';
      time = '$time $pmAm';
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





String? getTimeFormatOf12hours({required DateTime of}){
  String? result;

  try{


    var dateFormatOf12Hours = DateFormat("hh:mm a");
    var resultIn12 = dateFormatOf12Hours.format(of);
    var timePieces = resultIn12.split(' ');
    if (timePieces.length > 1) {
      result = '${timePieces.first} ${timePieces.last.tr}';
    }
  }catch (e){
    // println(e,'‼️');
  }


  return result;
}


