import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/exceptions/date_exceptions.dart';
import 'package:wassl/models/orders/order_type.dart';

import '../../helpers/exceptions/no_internet.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class FingerPrintController extends GetxController{

  final AppController appController = Get.find();

  DateTime? correctionDate;
  //1 = attend, 2 = leaving
  OrderType? attendanceStatus;

  String? reason;
  String? filePath;

  var correctionTime = ''.obs;
  var loading = false.obs;

  Future sendRequest() async {
    println(filePath);
    if(correctionDate == null){
      throw StartDateException();
    }
    if(attendanceStatus == null){
      throw ChooseTypeException();
    }
    if(correctionTime.value.isEmpty){
      throw ChooseTimeException();
    }

    if(reason == null){
      throw EnterReasonException();
    }
//2023-01-22
    var body = {
      'date':'${correctionDate?.year}-${correctionDate?.month}-${correctionDate?.day}',
      'working_type':'${attendanceStatus?.id}',
      'time':'${correctionTime.value}:00',
      'reason':'$reason'
    };

    println(body);
    println(appController.appHeader);
    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addFingerPrintCorrection, body: body,header: appController.appHeader,fileName: filePath);
    println(response.statusCode);
    println(await response.stream.bytesToString());
    loading.value = false;
    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }

  }

  Future updateRequest(String orderId) async{
    if(correctionDate == null){
      throw StartDateException();
    }
    if(attendanceStatus == null){
      throw ChooseTypeException();
    }
    if(correctionTime.value.isEmpty){
      throw ChooseTimeException();
    }

    if(reason == null){
      throw EnterReasonException();
    }
//2023-01-22
    var body = {
      'date':'${correctionDate?.year}-${correctionDate?.month}-${correctionDate?.day}',
      'working_type':'${attendanceStatus?.id}',
      'time':'${correctionTime.value}:00',
      'reason':'$reason'
    };


    println(body);
    println('${AppUrls.updateFingerPrintCorrection}/$orderId');
    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updateFingerPrintCorrection}/$orderId', body: body,header: appController.appHeader,fileName: filePath);
    println(await response.stream.bytesToString());
    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
  }

  Future cancelRequest(String orderId) async{


    println('${AppUrls.cancelHolidayRequest}/$orderId');
    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelFingerPrintCorrection}/$orderId',header: appController.appHeader, );
    println(response.statusCode);
    println(response.body);
    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
  }

  String get timeOfDay{
    var time = '-----';
    println(correctionTime.value);
    if(correctionTime.value.isNotEmpty){
      var timeList = correctionTime.split(':');
      int hours = int.tryParse(timeList[0]) ?? 0;
      int minutes = int.tryParse(timeList[1]) ?? 0;
      var pm_am = hours > 12 ? 'pm'.tr : 'am'.tr;
      hours = hours > 12 ? hours - 12 : hours;
      time = hours == 0 ? '12' : hours < 10 ? '0$hours' : '$hours';
      time += minutes < 10 ? ':0$minutes' : ':$minutes';
      time = '$time $pm_am';
    }

    return time;
  }



  var attendTypes = [
    OrderType(id: 1,name: 'attending'.tr),
    OrderType(id: 2,name: 'leaving'.tr),
  ];

}