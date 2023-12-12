import 'package:get/get.dart';

import '../../controllers/types_controllers.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../helpers/exceptions/internet_api_exceptions.dart';
import '../../models/orders/order_type.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';
import 'order_types_controller.dart';

class VisaRequestController extends GetxController {
  var loadingTypes = false.obs;
  var loading = false.obs;
  final AppController appController = Get.find();
  var visaTypes = OrderTypesRetriever().obs;
  var visaTimes = OrderTypesRetriever().obs;
  var ticketTypes = OrderTypesRetriever().obs;
  var haveTicket = true.obs;
  var goAndBackTicket = true.obs;

  OrderType? selectedType;
  OrderType? selectedTime;
  OrderType? selectedTicketType;

  DateTime? dateBefore;
  DateTime? goDate;
  DateTime? backDate;
  String? reason;
  String? filePath;
  var errorsList = <String>[].obs;

  Future addNewRequest() async {
    if (selectedType == null) {
      throw CustomException(errorMessage: 'visa_type_exception');
    }
    if (selectedTime == null) {
      throw CustomException(errorMessage: 'visa_time_exception');
    }
    if (dateBefore == null) {
      throw CustomException(errorMessage: 'date_before_exception');
    }
    if (haveTicket.value) {
      if (selectedTicketType == null) {
        throw CustomException(errorMessage: 'ticket_type_exception');
      }
      if (goDate == null) {
        throw CustomException(errorMessage: 'go_date_exception');
      }
      if (goAndBackTicket.value) {
        if (backDate == null) {
          throw CustomException(errorMessage: 'back_date_exception');
        }
      }
    }

    if (reason == null || reason == '') {
      throw CustomException(errorMessage: 'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'visa_time': '${selectedTime?.id}',
      'required_before':
          '${dateBefore?.year}-${dateBefore?.month}-${dateBefore?.day}',
      'reason': '$reason'
    };
    if (haveTicket.value) {
      body.addAll({
        'ticket': 'on',
        'ticket_type': '${selectedTicketType?.id}',
        'go_date': '${goDate?.year}-${goDate?.month}-${goDate?.day}',
      });
    }
    if (goAndBackTicket.value) {
      body.addAll({
        'back_date': '${backDate?.year}-${backDate?.month}-${backDate?.day}',
      });
    }

    loading.value = true;
    var response = await AppApiHandler.postDataWithFile(
        url: AppUrls.addVisa,
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
    if (selectedType == null) {
      throw CustomException(errorMessage: 'visa_type_exception');
    }
    if (selectedTime == null) {
      throw CustomException(errorMessage: 'visa_time_exception');
    }
    if (dateBefore == null) {
      throw CustomException(errorMessage: 'date_before_exception');
    }
    if (haveTicket.value) {
      if (selectedTicketType == null) {
        throw CustomException(errorMessage: 'ticket_type_exception');
      }
      if (goDate == null) {
        throw CustomException(errorMessage: 'go_date_exception');
      }
      if (goAndBackTicket.value) {
        if (backDate == null) {
          throw CustomException(errorMessage: 'back_date_exception');
        }
      }
    }

    if (reason == null || reason == '') {
      throw CustomException(errorMessage: 'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'visa_time': '${selectedTime?.id}',
      'required_before':
          '${dateBefore?.year}-${dateBefore?.month}-${dateBefore?.day}',
      'reason': '$reason'
    };
    if (haveTicket.value) {
      body.addAll({
        'ticket': 'on',
        'ticket_type': '${selectedTicketType?.id}',
        'go_date': '${goDate?.year}-${goDate?.month}-${goDate?.day}',
      });
    }
    if (goAndBackTicket.value) {
      body.addAll({
        'back_date': '${backDate?.year}-${backDate?.month}-${backDate?.day}',
      });
    }

    loading.value = true;
    var response = await AppApiHandler.postDataWithFile(
        url: '${AppUrls.updateVisa}/$orderId',
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
      url: '${AppUrls.cancelVisa}/$orderId',
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

  getTypes() async {
    loadingTypes.value = true;

    visaTypes.value = await TypesController()
            .getTypes(AppUrls.getVisaTypes, appController.appHeader) ??
        OrderTypesRetriever();

    visaTimes.value = await TypesController()
            .getTypes(AppUrls.getVisaTime, appController.appHeader) ??
        OrderTypesRetriever();

    ticketTypes.value = await TypesController()
            .getTypes(AppUrls.getTicketTypes, appController.appHeader) ??
        OrderTypesRetriever();

    loadingTypes.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTypes();
  }
}
