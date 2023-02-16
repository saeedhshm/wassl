import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/exceptions/date_exceptions.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import 'package:wassl/models/orders/holday/holiday_type.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../helpers/constants/print_ln.dart';

class HolidayController extends GetxController{
  final AppController appController = Get.find();

  DateTime? startDate;
  DateTime? endDate;
  HolidayType? holidayType;
  String? filePath;

  String? holidayReason;

  List<String> get holidaysType {
    return holidayTypes.map((e) => (e.name ?? '').tr).toList();
  }



  Future sendHolidayRequest() async {

    println(holidayType?.name);


    if(holidayType == null){
      throw ChooseTypeException();
    }

    if(startDate == null){
      throw StartDateException();
    }
    if(endDate == null){
      throw EndDateException();
    }
    if(holidayReason == null || holidayReason?.trim() == ''){
      throw EnterReasonException();
    }

    // body parameters

    var body = {
      'type':'${holidayType?.id}',
      'holiday_start':'${startDate?.year}-${startDate?.month}-${startDate?.day}',
      'holiday_end':'${endDate?.year}-${endDate?.month}-${endDate?.day}',
      'reason':'$holidayReason'
    };

    println(body);
    println(appController.appHeader);
  var response = await  AppApiHandler.sendDataWithFile(url: AppUrls.addHolidayRequest, body: body,header: appController.appHeader,fileName: filePath);
  if(response.statusCode != 200){
    throw NoDataAvailableException();
  }
  }

}