import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import '../../helpers/exceptions/custom_exception.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class OverTimeController extends GetxController{

  final AppController appController = Get.find();

  var loading = false.obs;
  DateTime? overTimeDate;
  var startTime = ''.obs;
  var endTime = ''.obs;
  String reason = '';
  String? filePath;

  Future addNewRequest() async{

    if(overTimeDate == null){
      throw CustomException(errorMessage: 'date_exception');
    }
    if(startTime.value.isEmpty){
      throw CustomException(errorMessage: 'startTime_exception');
    }
    if(endTime.value.isEmpty){
      throw CustomException(errorMessage: 'endTime_exception');
    }
    if(reason.isEmpty){
      throw CustomException(errorMessage: 'reason_exception');
    }

    var body = {
      'start_time': '${startTime.value}:00',
      'end_time': '${endTime.value}:00',
      'date':  '${overTimeDate?.year}-${overTimeDate?.month}-${overTimeDate?.day}',
      'reason': reason
    };

    println(AppUrls.addOvertimeApi);

    loading.value = true;
    var response = await  AppApiHandler.sendDataWithFile(url: AppUrls.addOvertimeApi, body: body,header: appController.appHeader,fileName: filePath);
    println(response.statusCode);
    println(await response.stream.bytesToString());
    loading.value = false;
    if(response.statusCode != 200){
      throw CustomException(errorMessage: 'response.statusCode ${response.statusCode}');
    }

  }
}