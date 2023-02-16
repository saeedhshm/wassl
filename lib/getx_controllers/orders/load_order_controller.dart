import 'package:get/get.dart';

import '../../helpers/constants/print_ln.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../helpers/exceptions/no_internet.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class LoanOrderController extends GetxController{

  var loading = false.obs;
  final AppController appController = Get.find();

  String? reason;
  String? filePath;
  int? loanType;
  String? amount;
  DateTime? loanStartingDate;
  String? installmentMonthlyAmount;
  String? monthlyInstallmentMethod;

 Future addNewLoad() async {


   // [8:24 am, 15/02/2023] محمد مبارك السودان: 1 = سكني
   // [8:24 am, 15/02/2023] محمد مبارك السودان: 2 = شخصي
   // [8:24 am, 15/02/2023] محمد مبارك السودان: 3 = عاجل
   // [8:25 am, 15/02/2023] محمد مبارك السودان: 4 = مصاريف سفر

   if(loanType == null){
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
      'type':"$loanType",
      'amount':"$amount",
      'month':"${loanStartingDate?.year}-${loanStartingDate?.month}-${loanStartingDate?.day}",
      'monthly_installment':"تحديد مبلغ شهري معيّن",
      'installment_amount':"$installmentMonthlyAmount",
      'reason':"$reason",
    };
    // loading.value = true;

    println(body);
    println(appController.appHeader);

    loading.value = true;
    var response = await  AppApiHandler.sendDataWithFile(url: AppUrls.addloan, body: body,header: appController.appHeader,fileName: filePath);
    println(response.statusCode);
    println(await response.stream.bytesToString());
    loading.value = false;
    if(response.statusCode != 200){
      throw CustomException();
    }


  }
}