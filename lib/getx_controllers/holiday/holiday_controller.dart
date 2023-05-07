import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/exceptions/date_exceptions.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import 'package:wassl/models/orders/order_type.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../helpers/constants/print_ln.dart';
import '../orders/order_types_controller.dart';

class HolidayController extends GetxController{

  final AppController appController = Get.find();

  DateTime? startDate;
  DateTime? endDate;
  var orderTypes = OrderTypesRetriever().obs;
  OrderType? selectedType;
  String? filePath;
  var loadingHolidayTypes = false.obs;
  var loading = false.obs;
  String? holidayReason;

  var errorsList = <String>[].obs;

 var differenceInDays = ''.obs;



  Future sendHolidayRequest() async {




    if(selectedType == null){
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
      'type':'${selectedType?.id}',
      'holiday_start':'${startDate?.year}-${startDate?.month}-${startDate?.day}',
      'holiday_end':'${endDate?.year}-${endDate?.month}-${endDate?.day}',
      'reason':'$holidayReason'
    };

    println(body);

    // throw NoDataAvailableException();
    // return;
    println(appController.appHeader);
  var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.addHolidayRequest}', body: body,header: appController.appHeader,fileName: filePath);
  if(response.statusCode != 200){
    errorsList.addAll(appController.listOfErrors);
    errorsList.add('body: $body');
    errorsList.add('url: ${AppUrls.addHolidayRequest}d');
    errorsList.add('response.statusCode: ${response.statusCode}');
    errorsList.add('response.body: ${await response.stream.bytesToString()}');
    throw NoDataAvailableException();
  }
  }

  Future updateRequest(String orderId) async{
    if(selectedType == null){
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
      'type':'${selectedType?.id}',
      'holiday_start':'${startDate?.year}-${startDate?.month}-${startDate?.day}',
      'holiday_end':'${endDate?.year}-${endDate?.month}-${endDate?.day}',
      'reason':'$holidayReason'
    };

    println(body);
    println(appController.appHeader);
    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updateHolidayRequest}/$orderId', body: body,header: appController.appHeader,fileName: filePath);
    if(response.statusCode != 200){
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}d');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${await response.stream.bytesToString()}');
      throw NoDataAvailableException();
    }
  }

  Future cancelRequest(String orderId) async{


    println('${AppUrls.cancelHolidayRequest}/$orderId');
    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelHolidayRequest}/$orderId',header: appController.appHeader, );
    println(response.statusCode);
    println(response.body);
    if(response.statusCode != 200){
      errorsList.addAll(appController.listOfErrors);
      // errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}d');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${await response.body}');
      throw NoDataAvailableException();
    }
  }

  getHolidaysTypes() async {

    loadingHolidayTypes.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.getHolidayTypes,header: appController.appHeader);

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      orderTypes.value = OrderTypesRetriever.fromJson(json);
    }
    loadingHolidayTypes.value = false;
    println(response.statusCode);
    println(response.body);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHolidaysTypes();

  }


  setDifferenceInDays(){

      String difference = '';
      // var startDayARR = (startDate.toString() ?? '').split('-');
      // var endDayARR = (endDate.toString() ?? '').split('-');
      //
      // final startDay = DateTime(int.parse(startDayARR[0]),int.parse(startDayARR[1]),int.parse(startDayARR[2]));
      // final endDay = DateTime(int.parse(endDayARR[0]),int.parse(endDayARR[1]),int.parse(endDayARR[2]));


      final days = (endDate!.difference(startDate!).inDays + 1);
      difference = days == 1 ? 'day'.tr : days == 2 ? '2_days'.tr : days > 10 ? days.toString() + ' ' + 'day'.tr : (days.toString() + ' ' + 'days'.tr);
      differenceInDays.value = 'holiday_time'.tr +': ' +difference;

  }
}