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

class LoanOrderController extends GetxController{

  var loading = false.obs;
  var loadingLoansTypes = false.obs;


  final AppController appController = Get.find();

  String? reason;
  String? filePath;
  var orderTypes = OrderTypesRetriever().obs;
  OrderType? selectedType;
  String? amount;
  DateTime? loanStartingDate;
  String? installmentMonthlyAmount;
  String? monthlyInstallmentMethod;
  var errorsList = <String>[].obs;

 Future addNewLoad() async {



   if(selectedType == null){
     throw CustomException(errorMessage:'loanType_exception');
   }
   if(amount == null || amount == ''){
     throw CustomException(errorMessage:'amount_exception');
   }
   if(loanStartingDate == null){
     throw CustomException(errorMessage:'loanStartingDate_exception');
   }
   if(installmentMonthlyAmount == null || installmentMonthlyAmount == ''){
     throw CustomException(errorMessage:'installmentMonthlyAmount_exception');
   }

   if(monthlyInstallmentMethod == null || monthlyInstallmentMethod == ''){
     throw CustomException(errorMessage:'installmentMonthlyMethod_exception');
   }
   if(reason == null || reason == ''){
     throw CustomException(errorMessage:'reason_exception');
   }

    var body = {
      'type':"${selectedType?.id}",
      'amount':"$amount",
      'month':"${loanStartingDate?.year}-${loanStartingDate?.month}-${loanStartingDate?.day}",
      'monthly_installment':"$monthlyInstallmentMethod",
      'installment_amount':"$installmentMonthlyAmount",
      'reason':"$reason",
    };
    // loading.value = true;


    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addLoan, body: body,header: appController.appHeader,fileName: filePath);

    loading.value = false;
    if(response.statusCode != 200){
      var responsebody = await response.stream.bytesToString();
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addLoan}');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: $responsebody');
      throw CustomException();
    }


  }

  Future updateRequest(String orderId) async {


    // [8:24 am, 15/02/2023] محمد مبارك السودان: 1 = سكني
    // [8:24 am, 15/02/2023] محمد مبارك السودان: 2 = شخصي
    // [8:24 am, 15/02/2023] محمد مبارك السودان: 3 = عاجل
    // [8:25 am, 15/02/2023] محمد مبارك السودان: 4 = مصاريف سفر

    if(selectedType == null){
      throw CustomException(errorMessage:'loanType_exception');
    }
    if(amount == null || amount == ''){
      throw CustomException(errorMessage:'amount_exception');
    }
    if(loanStartingDate == null){
      throw CustomException(errorMessage:'loanStartingDate_exception');
    }
    if(installmentMonthlyAmount == null || installmentMonthlyAmount == ''){
      throw CustomException(errorMessage:'installmentMonthlyAmount_exception');
    }

    if(monthlyInstallmentMethod == null || monthlyInstallmentMethod == ''){
      throw CustomException(errorMessage:'installmentMonthlyMethod_exception');
    }
    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type':"${selectedType?.id}",
      'amount':"$amount",
      'month':"${loanStartingDate?.year}-${loanStartingDate?.month}-${loanStartingDate?.day}",
      'monthly_installment':"$monthlyInstallmentMethod",
      'installment_amount':"$installmentMonthlyAmount",
      'reason':"$reason",
    };
    // loading.value = true;


    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updateLoan}/$orderId', body: body,header: appController.appHeader,fileName: filePath);

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


    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelLoan}/$orderId',header: appController.appHeader, );

    if(response.statusCode != 200){
      errorsList.addAll(appController.listOfErrors);
      // errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}d');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${response.body}');
      throw NoDataAvailableException();
    }
  }

  getLoansTypes() async {

    loadingLoansTypes.value = true;


    orderTypes.value = await TypesController().getTypes(AppUrls.getLoansTypes, appController.appHeader) ?? OrderTypesRetriever();


    loadingLoansTypes.value = false;

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLoansTypes();
  }

}