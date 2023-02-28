import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/constants/print_ln.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../helpers/exceptions/no_internet.dart';
import '../../models/orders/order_type.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';
import 'order_types_controller.dart';

class LetterRequestController extends GetxController{

  var loading = false.obs;
  var loadingLetterTypes = false.obs;
  final AppController appController = Get.find();

  String? reason;
  String? filePath;
  int? type;
  String? directedToAr;
  String? directedToEn;
  var orderTypes = OrderTypesRetriever().obs;
  OrderType? selectedType;


  Future addNewLetter()async{

    if(selectedType == null) {
      throw CustomException(errorMessage: 'letter_type_exception');
    }
    if(directedToAr == null || directedToAr == ''){
      throw CustomException(errorMessage: 'directed_to_ar_exception');
    }
    if(directedToEn == null || directedToEn == ''){
      throw CustomException(errorMessage: 'directed_to_en_exception');
    }
    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'directed_to_en': '$directedToEn',
      'directed_to_ar': '$directedToAr',
      'reason': '$reason'
    };
    println(body);


    println(body);
    println(appController.appHeader);

    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addLetter, body: body,header: appController.appHeader,fileName: filePath);
    println(response.statusCode);
    println(await response.stream.bytesToString());
    loading.value = false;
    if(response.statusCode != 200){
      throw CustomException();
    }

  }

  Future updateRequest(String orderId)async{

    if(selectedType == null) {
      throw CustomException(errorMessage: 'letter_type_exception');
    }
    if(directedToAr == null || directedToAr == ''){
      throw CustomException(errorMessage: 'directed_to_ar_exception');
    }
    if(directedToEn == null || directedToEn == ''){
      throw CustomException(errorMessage: 'directed_to_en_exception');
    }
    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'directed_to_en': '$directedToEn',
      'directed_to_ar': '$directedToAr',
      'reason': '$reason'
    };
    println(body);


    println(body);
    println(appController.appHeader);

    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updateLetter}/$orderId', body: body,header: appController.appHeader,fileName: filePath);
    println(response.statusCode);
    println(await response.stream.bytesToString());
    loading.value = false;
    if(response.statusCode != 200){
      throw CustomException();
    }

  }

  Future cancelRequest(String orderId) async{


    println('${AppUrls.cancelHolidayRequest}/$orderId');
    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelLetter}/$orderId',header: appController.appHeader, );
    println(response.statusCode);
    println(response.body);
    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
  }

  getLetterTypes() async {

    loadingLetterTypes.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.getLetterTypes,header: appController.appHeader);

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      orderTypes.value = OrderTypesRetriever.fromJson(json);
    }
    loadingLetterTypes.value = false;
    println(response.statusCode);
    println(response.body);
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLetterTypes();
  }

}