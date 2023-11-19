import 'package:get/get.dart';
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

  var errorsList = <String>[].obs;

  Future sendRequest() async {
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


    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addFingerPrintCorrection, body: body,header: appController.appHeader,fileName: filePath);

    loading.value = false;
    if(response.statusCode != 200){
      var responsebody = await response.stream.bytesToString();
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: $responsebody');
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



    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updateFingerPrintCorrection}/$orderId', body: body,header: appController.appHeader,fileName: filePath);

    if(response.statusCode != 200){
      var responsebody = await response.stream.bytesToString();
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: $responsebody');
      throw NoDataAvailableException();
    }
  }

  Future cancelRequest(String orderId) async{


    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelFingerPrintCorrection}/$orderId',header: appController.appHeader, );

    if(response.statusCode != 200){
      errorsList.addAll(appController.listOfErrors);
      // errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}d');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${response.body}');
      throw NoDataAvailableException();
    }
  }

  String get timeOfDay{
    var time = '-----';

    if(correctionTime.value.isNotEmpty){
      var timeList = correctionTime.split(':');
      int hours = int.tryParse(timeList[0]) ?? 0;
      int minutes = int.tryParse(timeList[1]) ?? 0;
      var pmAm = hours > 12 ? 'pm'.tr : 'am'.tr;
      hours = hours > 12 ? hours - 12 : hours;
      time = hours == 0 ? '12' : hours < 10 ? '0$hours' : '$hours';
      time += minutes < 10 ? ':0$minutes' : ':$minutes';
      time = '$time $pmAm';
    }

    return time;
  }



  var attendTypes = [
    OrderType(id: 1,)..name = 'attending'.tr,
    OrderType(id: 2,)..name = 'leaving'.tr,
  ];

}