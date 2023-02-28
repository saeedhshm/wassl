import 'package:get/get.dart';

import '../../helpers/constants/print_ln.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class FinanceSpendedRequestController extends GetxController{

  final AppController appController = Get.find();

  var loading = false.obs;
  DateTime? date;
  String? reason;
  String? filePath;

  String? title;
  String? amount;
  String? description;


  Future addNewRequest() async{

    if(title == null || title == ''){
      throw CustomException(errorMessage:'finencial_title_exception');
    }
    if(amount == null || amount == ''){
      throw CustomException(errorMessage:'finencial_amount_exception');
    }

    if(date == null){
      throw CustomException(errorMessage: 'inter_date_exception');
    }

    if(description == null || description == ''){
      throw CustomException(errorMessage:'description_exception');
    }

    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }


    var body = {
      'name': '$title',
      'amount': '$amount',
      'date': '${date?.year}-${date?.month}-${date?.day}',
      'description': '$description',
      'reason': '$reason'
    };

    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addFinancialExpenses, body: body,header: appController.appHeader,fileName: filePath);
    println(response.statusCode);
    println(await response.stream.bytesToString());
    loading.value = false;
    if(response.statusCode != 200){
      throw CustomException();
    }
  }

}
