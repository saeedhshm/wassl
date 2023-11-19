
import 'package:get/get.dart';

import '../../controllers/types_controllers.dart';
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
  var errorsList = <String>[].obs;


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


    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addLetter, body: body,header: appController.appHeader,fileName: filePath);


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



    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updateLetter}/$orderId', body: body,header: appController.appHeader,fileName: filePath);

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


    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelLetter}/$orderId',header: appController.appHeader, );

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

    orderTypes.value = await TypesController().getTypes(AppUrls.getLetterTypes, appController.appHeader) ?? OrderTypesRetriever();


    loadingLetterTypes.value = false;



  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLetterTypes();
  }

}