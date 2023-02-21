import 'package:wassl/helpers/constants/print_ln.dart';

import 'ask_permission.dart';
import 'custoday.dart';
import 'financial_expenses.dart';
import 'finger_print.dart';
import 'holiday.dart';
import 'letter.dart';
import 'loan_order.dart';

class AllOrders {

  List<Order> orders = [];

  bool? success;
  List<LoansData> loansData = [];
  List<LetterDate> letterDate = [];
  List<FinancialExpensesDate> financialExpensesDate = [];
  List<CustodyDate> custodyDate = [];
  List<HolidaysData> holidaysData = [];
  List<AskPermissionsData> askPermissionsData = [];
  List<FingerprintCorrectionsData> fingerprintCorrectionsData = [];
  // List<Null>? orderVisaData;
  String? message;

  AllOrders();

  AllOrders.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['LoansData'] != null) {

      json['LoansData'].forEach((v) {
        loansData.add( LoansData.fromJson(v));
      });
    }
    if (json['LetterDate'] != null) {

      json['LetterDate'].forEach((v) {
        letterDate.add( LetterDate.fromJson(v));
      });
    }
    if (json['FinancialExpensesDate'] != null) {

      json['FinancialExpensesDate'].forEach((v) {
        financialExpensesDate.add( FinancialExpensesDate.fromJson(v));
      });
    }
    if (json['CustodyDate'] != null) {

      json['CustodyDate'].forEach((v) {
        custodyDate.add( CustodyDate.fromJson(v));
      });
    }
    if (json['HolidaysData'] != null) {

      json['HolidaysData'].forEach((v) {
        holidaysData.add( HolidaysData.fromJson(v));
      });
    }

    if (json['AskPermissionsData'] != null) {

      json['AskPermissionsData'].forEach((v) {
        askPermissionsData.add( AskPermissionsData.fromJson(v));
      });
    }
    // if (json['FingerprintCorrectionsData'] != null) {
    //
    //   json['FingerprintCorrectionsData'].forEach((v) {
    //     fingerprintCorrectionsData
    //         .add( FingerprintCorrectionsData.fromJson(v));
    //   });
    // }
    // if (json['OrderVisaData'] != null) {
    //   orderVisaData = <Null>[];
    //   json['OrderVisaData'].forEach((v) {
    //     orderVisaData!.add(new Null.fromJson(v));
    //   });
    // }
    orders.addAll(holidaysData);
    orders.addAll(askPermissionsData);
    orders.addAll(fingerprintCorrectionsData);
    orders.addAll(custodyDate);
    orders.addAll(financialExpensesDate);
    orders.addAll(letterDate);
    orders.addAll(loansData);

    message = json['message'];
  }

//   bool get isEmpty{
//     return loansData.isEmpty && letterDate.isEmpty && financialExpensesDate.isEmpty && custodyDate.isEmpty && holidaysData.isEmpty && fingerprintCorrectionsData.isEmpty && askPermissionsData.isEmpty;
// }

}
abstract class Order{
  String get orderType;
  String get orderDate;
  String get orderStatus;
  String get reason;
}







