import 'package:get/get.dart';

import '../../helpers/exceptions/custom_exception.dart';
import '../../helpers/exceptions/internet_api_exceptions.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class FinanceSpendedRequestController extends GetxController {
  final AppController appController = Get.find();

  var loading = false.obs;
  DateTime? date;
  String? reason;
  String? filePath;

  String? title;
  String? amount;
  String? description;
  var errorsList = <String>[].obs;

  Future addNewRequest() async {
    if (title == null || title == '') {
      throw CustomException(errorMessage: 'finencial_title_exception');
    }
    if (amount == null || amount == '') {
      throw CustomException(errorMessage: 'finencial_amount_exception');
    }

    if (date == null) {
      throw CustomException(errorMessage: 'inter_date_exception');
    }

    if (description == null || description == '') {
      throw CustomException(errorMessage: 'description_exception');
    }

    if (reason == null || reason == '') {
      throw CustomException(errorMessage: 'reason_exception');
    }

    var body = {
      'name': '$title',
      'amount': '$amount',
      'date': '${date?.year}-${date?.month}-${date?.day}',
      'description': '$description',
      'reason': '$reason'
    };

    loading.value = true;
    var response = await AppApiHandler.postDataWithFile(
        url: AppUrls.addFinancialExpenses,
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
      throw CustomException();
    }
  }

  Future updateRequest(String orderId) async {
    if (title == null || title == '') {
      throw CustomException(errorMessage: 'finencial_title_exception');
    }
    if (amount == null || amount == '') {
      throw CustomException(errorMessage: 'finencial_amount_exception');
    }

    if (date == null) {
      throw CustomException(errorMessage: 'inter_date_exception');
    }

    if (description == null || description == '') {
      throw CustomException(errorMessage: 'description_exception');
    }

    if (reason == null || reason == '') {
      throw CustomException(errorMessage: 'reason_exception');
    }

    var body = {
      'name': '$title',
      'amount': '$amount',
      'date': '${date?.year}-${date?.month}-${date?.day}',
      'description': '$description',
      'reason': '$reason'
    };
    loading.value = true;
    var response = await AppApiHandler.postDataWithFile(
        url: '${AppUrls.updateFinancialExpenses}/$orderId',
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
      throw CustomException();
    }
  }

  Future cancelRequest(String orderId) async {
    var response = await AppApiHandler.putData(
      url: '${AppUrls.cancelFinancialExpenses}/$orderId',
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
