

const String _appDomain = 'https://waslhr.com';
const String _apiVrsion = '$_appDomain/api/v1';
class AppUrls {

  static const String _authApi = '$_apiVrsion/auth';
  static const String _assignApi = '$_apiVrsion/assign';
  static const String _attendanceApi = '$_apiVrsion/attendance';
  static const String _ordersApi = '$_apiVrsion/orders';
  static const String _holidayApi = '$_apiVrsion/holiday';
  static const String _fingerprintCorrectionApi = '$_apiVrsion/fingerprint_correction';
  static const String _loanApi = '$_apiVrsion/loan';
  static const String _letterApi = '$_apiVrsion/letter';

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
  //attendance
  static const String monthlyAttendance = '$_attendanceApi/month';

  //{{domain}}/get_holiday_types
  static const String getHolidayTypes = '$_apiVrsion/get_holiday_types';
  ///holiday/add
  static const String addHolidayRequest = '$_holidayApi/add';

  //fingerprint_correction/add
  static const String addFingerPrintCorrection = '$_fingerprintCorrectionApi/add';

  //{{domain}}/get_loan_types
  static const String getLoansTypes = '$_apiVrsion/get_loan_types';
  //loan/add
  static const String addLoan = '$_loanApi/add';

  //{{domain}}/get_letter_types
  static const String getLetterTypes = '$_apiVrsion/get_letter_types';
  //{{domain}}/letter/add
  static const String addLetter = '$_letterApi/add';

}

