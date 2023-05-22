

const String appDomain = 'https://waslhr.com';
const String _apiVrsion = '$appDomain/api/v1';

//https://waslhr.com/public/file/HNfw2wuXW6E3Z5yHL0dQjiHm9E7a50HdNJvfIB9Z.png
class AppUrls {

  static const String _authApi = '$_apiVrsion/auth';
  static const String _assignApi = '$_apiVrsion/assign';
  static const String _attendanceApi = '$_apiVrsion/attendance';
  static const String _ordersApi = '$_apiVrsion/orders';
  static const String _holidayApi = '$_apiVrsion/holiday';
  static const String _fingerprintCorrectionApi = '$_apiVrsion/fingerprint_correction';
  static const String _loanApi = '$_apiVrsion/loan';
  static const String _letterApi = '$_apiVrsion/letter';
  static const String _askPermissionApi = '$_apiVrsion/ask_permission';
  static const String _financialExpensesApi = '$_apiVrsion/financial_expenses';
  static const String _custodyApi = '$_apiVrsion/custody';
  static const String _visaApi = '$_apiVrsion/visa';
  static const String _overtimeApi = '$_apiVrsion/overtime';

  //https://waslhr.com/api/v1/auth
  static const String login = '$_authApi/login';
  static const String logout = '$_authApi/logout';
  static const String changePassword = '$_authApi/save_my_password';

  //https://waslhr.com/api/v1/assign
  static const String attendance = '$_assignApi/attendance';
  static const String leaving = '$_assignApi/leave';
  static const String attendanceCheck = '$_assignApi/check';

  ///orders/get
  static const String getAllOrders = '$_ordersApi/get';
  //{{domain}}/orders/get-team-orders
  static const String getTeamOrders = '$_ordersApi/get-team-orders';
  static const String setTeamOrderSatus = '$_ordersApi/set-team-order-status';

  //attendance
  static const String monthlyAttendance = '$_attendanceApi/month';

  //{{domain}}/get_holiday_types
  static const String getHolidayTypes = '$_apiVrsion/get_holiday_types';

  ///holiday/add
  static const String addHolidayRequest = '$_holidayApi/add';
  //{{domain}}/holiday/update/22
  static const String updateHolidayRequest = '$_holidayApi/update';
  //{{domain}}/holiday/cancel/9
  static const String cancelHolidayRequest = '$_holidayApi/cancel';


  //fingerprint_correction/add
  static const String addFingerPrintCorrection = '$_fingerprintCorrectionApi/add';
//{{domain}}/fingerprint_correction/cancel/8
  static const String cancelFingerPrintCorrection = '$_fingerprintCorrectionApi/cancel';
  //{{domain}}/fingerprint_correction/update/5
  static const String updateFingerPrintCorrection = '$_fingerprintCorrectionApi/update';



  //{{domain}}/get_loan_types
  static const String getLoansTypes = '$_apiVrsion/get_loan_types';
  //loan/add
  static const String addLoan = '$_loanApi/add';
  //{{domain}}/loan/update/7
  static const String updateLoan = '$_loanApi/update';
  // {{domain}}/loan/cancel/9
  static const String cancelLoan = '$_loanApi/cancel';


  //{{domain}}/get_letter_types
  static const String getLetterTypes = '$_apiVrsion/get_letter_types';
  //{{domain}}/letter/add
  static const String addLetter = '$_letterApi/add';
  // {{domain}}/letter/update/5
  static const String updateLetter = '$_letterApi/update';
  //{{domain}}/letter/cancel/7
  static const String cancelLetter = '$_letterApi/cancel';

  //{{domain}}/get_ask_permission_types
  static const String getPermissionsTypes = '$_apiVrsion/get_ask_permission_types';
  //{{domain}}/ask_permission/add
  static const String addPermission = '$_askPermissionApi/add';
  // {{domain}}/ask_permission/cancel/9
  static const String cancelPermission = '$_askPermissionApi/cancel';
  //{{domain}}/ask_permission/update/7
  static const String updatePermission = '$_askPermissionApi/update';



  //{{domain}}/financial_expenses/add
  static const String addFinancialExpenses = '$_financialExpensesApi/add';
  //{{domain}}/financial_expenses/update/4
  static const String updateFinancialExpenses = '$_financialExpensesApi/update';
  // {{domain}}/financial_expenses/cancel/6
  static const String cancelFinancialExpenses = '$_financialExpensesApi/cancel';

  //{{domain}}/get_custody_types
  static const String getCustodyTypes = '$_apiVrsion/get_custody_types';
  //{{domain}}/custody/add
  static const String addCustody = '$_custodyApi/add';
  //{{domain}}/custody/cancel/3
  static const String cancelCustody = '$_custodyApi/cancel';
  //{{domain}}/custody/update/3
  static const String updateCustody = '$_custodyApi/update';

  //{{domain}}/get_ticket_types
  static const String getTicketTypes = '$_apiVrsion/get_ticket_types';
  //{{domain}}/get_visa_time
  static const String getVisaTime = '$_apiVrsion/get_visa_time';
//{{domain}}/get_visa_types
  static const String getVisaTypes = '$_apiVrsion/get_visa_types';
  //{{domain}}/visa/add
  static const String addVisa = '$_visaApi/add';
  //{{domain}}/visa/update/3
  static const String updateVisa = '$_visaApi/update';
  //{{domain}}/visa/cancel/3
  static const String cancelVisa = '$_visaApi/cancel';



  //{{domain}}/overtime/add
  static const String addOvertimeApi = '$_overtimeApi/add';
  //{{domain}}/overtime/update/2
  static const String updateOvertimeApi = '$_overtimeApi/update';
  // {{domain}}/overtime/cancel/2
  static const String cancelOvertimeApi = '$_overtimeApi/cancel';

  //https://waslhr.com/api/v1/documents
  static const String documentsApi = '$_apiVrsion/documents';
  //https://waslhr.com/api/v1/covenant
  static const String covenantApi = '$_apiVrsion/covenant';

}

