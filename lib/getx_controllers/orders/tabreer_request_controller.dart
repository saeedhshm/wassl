import 'dart:convert';

import 'package:get/get.dart';

import '../../controllers/types_controllers.dart';
import '../../helpers/constants/print_ln.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../helpers/exceptions/no_internet.dart';
import '../../models/orders/order_type.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';
import 'order_types_controller.dart';

class ApologyRequestController extends GetxController{

  var loading = false.obs;
  var loadingLetterTypes = false.obs;
  final AppController appController = Get.find();

  DateTime? date;
  String? reason;
  String? filePath;
  int? type;

  var orderTypes = OrderTypesRetriever().obs;
  OrderType? selectedType;
  var errorsList = <String>[].obs;


  Future addNewRequest()async{




    if(selectedType == null) {
      throw CustomException(errorMessage: 'letter_type_exception');
    }

    if(date == null){
      throw CustomException(errorMessage: 'inter_date_exception');
    }
    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'date': '${date?.year}-${date?.month}-${date?.day}',
      'reason': '$reason'
    };


    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addTabreerApi, body: body,header: appController.appHeader,fileName: filePath);



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
      throw CustomException(errorMessage: 'letter_type_exception');
    }
    if(date == null){
      throw CustomException(errorMessage: 'inter_date_exception');
    }
    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'date': '${date?.year}-${date?.month}-${date?.day}',
      'reason': '$reason'
    };



    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updateTabreerApi}/$orderId', body: body,header: appController.appHeader,fileName: filePath);

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


    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelTabreerApi}/$orderId',header: appController.appHeader, );

    if(response.statusCode != 200){
      errorsList.addAll(appController.listOfErrors);
      // errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}d');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${response.body}');
      throw NoDataAvailableException();
    }
  }

  getLetterTypes() async {

    loadingLetterTypes.value = true;

    orderTypes.value = await TypesController().getTypes(AppUrls.tabreerTypesApi, appController.appHeader) ?? OrderTypesRetriever();


    loadingLetterTypes.value = false;

  }

setDate(String date){
    var splitDate = date.split('-');

    this.date = DateTime(int.tryParse(splitDate[0]) ?? 0,int.tryParse(splitDate[1]) ?? 0,int.tryParse(splitDate[2]) ?? 0,);

}

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLetterTypes();
  }

}