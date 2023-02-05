
import 'package:get/get.dart';

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
// ···
}

extension FormatedDateTimeExtension on String{
  String formattedTime(){
    var myTime = '----';
    var timeSpieces = this.split(':');
    if(timeSpieces.length > 1){
      myTime = _formattedTime(timeSpieces);
    }
    return myTime;
  }

  String formattedTimeFromDateTime(){
    var myTime = '----';
    var splitedDate = split(' ');
    var timeSpieces = splitedDate[1].split(':');


    if(timeSpieces.length > 1){
      myTime = _formattedTime(timeSpieces);
    }
    return myTime;
  }
}

String _formattedTime(List<String> timeSpieces){
  int hours = int.tryParse(timeSpieces[0]) ?? 0;
  int minuts = int.tryParse(timeSpieces[1]) ?? 0;
  String status = '';
  if(hours > 12){
    hours = hours - 12;
    return '${hours == 0 ? 12 : hours < 10 ? '0$hours' : hours}:${minuts == 0 ? '00' : minuts < 10 ? '0$minuts' : minuts} ${'pm'.tr}';
  }else {
    return '${hours == 0 ? 12 : hours < 10 ? '0$hours' : hours}:${minuts == 0 ? '00' : minuts} ${'am'.tr}';
  }
}