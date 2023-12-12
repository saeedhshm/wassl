import 'package:get/get.dart';

import '../../helpers/exceptions/custom_exception.dart';
import '../../helpers/exceptions/internet_api_exceptions.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class OverTimeController extends GetxController {
  final AppController appController = Get.find();

  var loading = false.obs;
  DateTime? overTimeDate;
  var startTime = ''.obs;
  var endTime = ''.obs;
  String reason = '';
  String? filePath;
  var errorsList = <String>[].obs;

  Future addNewRequest() async {
    if (overTimeDate == null) {
      throw CustomException(errorMessage: 'date_exception');
    }
    if (startTime.value.isEmpty) {
      throw CustomException(errorMessage: 'startTime_exception');
    }
    if (endTime.value.isEmpty) {
      throw CustomException(errorMessage: 'endTime_exception');
    }
    if (reason.isEmpty) {
      throw CustomException(errorMessage: 'reason_exception');
    }

    var body = {
      'start_time': '${startTime.value}:00',
      'end_time': '${endTime.value}:00',
      'date':
          '${overTimeDate?.year}-${overTimeDate?.month}-${overTimeDate?.day}',
      'reason': reason
    };

    loading.value = true;
    var response = await AppApiHandler.postDataWithFile(
        url: AppUrls.addOvertimeApi,
        body: body,
        header: appController.appHeader,
        fileName: filePath);

    // println(response.statusCode);
    // var respo = await response.stream.bytesToString();
    // println(respo);
    loading.value = false;
    if (response.statusCode != 200) {
      var responsebody = await response.stream.bytesToString();
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: $responsebody');
      throw CustomException(
          errorMessage: 'response.statusCode ${response.statusCode}');
    }
  }

  Future updateRequest(String orderId) async {
    if (overTimeDate == null) {
      throw CustomException(errorMessage: 'date_exception');
    }
    if (startTime.value.isEmpty) {
      throw CustomException(errorMessage: 'startTime_exception');
    }
    if (endTime.value.isEmpty) {
      throw CustomException(errorMessage: 'endTime_exception');
    }
    if (reason.isEmpty) {
      throw CustomException(errorMessage: 'reason_exception');
    }

    var body = {
      'start_time': '${startTime.value}:00',
      'end_time': '${endTime.value}:00',
      'date':
          '${overTimeDate?.year}-${overTimeDate?.month}-${overTimeDate?.day}',
      'reason': reason
    };

    loading.value = true;
    var response = await AppApiHandler.postDataWithFile(
        url: '${AppUrls.updateOvertimeApi}/$orderId',
        body: body,
        header: appController.appHeader,
        fileName: filePath);

    loading.value = false;
    if (response.statusCode != 200) {
      var responsebody = await response.stream.bytesToString();
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: $responsebody');
      throw CustomException(
          errorMessage: 'response.statusCode ${response.statusCode}');
    }
  }

  Future cancelRequest(String orderId) async {
    var response = await AppApiHandler.putData(
      url: '${AppUrls.cancelOvertimeApi}/$orderId',
      header: appController.appHeader,
    );

    if (response.statusCode != 200) {
      errorsList.addAll(appController.listOfErrors);
      // errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}d');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${response.body}');
      throw NoDataAvailableException();
    }
  }
}
