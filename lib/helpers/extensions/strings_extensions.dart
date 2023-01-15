
import 'package:get/get.dart';

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
// ···
}

extension FormatedDateTimeExtension on String{
  String formatedTime(){
    var myTime = 'unsupported_time';
    var timeSpieces = this.split(':');

    if(timeSpieces.length > 1){
      int hours = int.tryParse(timeSpieces[0]) ?? 0;
      int minuts = int.tryParse(timeSpieces[1]) ?? 0;
      String status = '';
      if(hours > 12){
        myTime = '${hours - 12}:${minuts == 0 ? '00' : minuts} ${'pm'.tr}';
      }else {
        myTime = '${hours == 0 ? 12 : hours}:${minuts == 0 ? '00' : minuts} ${'am'.tr}';
      }
    }
    return myTime;
  }
}