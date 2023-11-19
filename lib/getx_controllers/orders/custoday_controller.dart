
import 'package:get/get.dart';

import '../../controllers/types_controllers.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../helpers/exceptions/no_internet.dart';
import '../../models/orders/order_type.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';
import 'order_types_controller.dart';

class CustodyRequestController extends GetxController{

  final AppController appController = Get.find();
  var orderTypes = OrderTypesRetriever().obs;
  OrderType? selectedType;
  String? reason;
  String? filePath;
  var loadingTypes = false.obs;
  var loading = false.obs;
  var errorsList = <String>[].obs;

  Future addNewPermission()async{

    if(selectedType == null) {
      throw CustomException(errorMessage: 'permission_type_exception');
    }

    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'reason': '$reason'
    };


    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addCustody, body: body,header: appController.appHeader,fileName: filePath);

    loading.value = false;
    if(response.statusCode != 200){
      var responsebody = await response.stream.bytesToString();
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: $responsebody');
      throw CustomException();
    }

  }

  Future updateRequest(String orderId)async{

    if(selectedType == null) {
      throw CustomException(errorMessage: 'permission_type_exception');
    }

    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'reason': '$reason'
    };


    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updateCustody}/$orderId', body: body,header: appController.appHeader,fileName: filePath);

    loading.value = false;
    if(response.statusCode != 200){
      var responsebody = await response.stream.bytesToString();
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: $responsebody');
      throw CustomException();
    }

  }

  Future cancelRequest(String orderId) async{


    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelCustody}/$orderId',header: appController.appHeader, );

    if(response.statusCode != 200){
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

    orderTypes.value = await TypesController().getTypes(AppUrls.getCustodyTypes, appController.appHeader) ?? OrderTypesRetriever();


    loadingTypes.value = false;

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTypes();
  }
}