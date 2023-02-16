

const String _appDomain = 'https://waslhr.com';
const String _apiVrsion = '/api/v1';
class AppUrls {

  static const String _authApi = '$_appDomain$_apiVrsion/auth';
  static const String _assignApi = '$_appDomain$_apiVrsion/assign';
  static const String _attendanceApi = '$_appDomain$_apiVrsion/attendance';
  static const String _ordersApi = '$_appDomain$_apiVrsion/orders';
  static const String _holidayApi = '$_appDomain$_apiVrsion/holiday';
  static const String _fingerprintCorrectionApi = '$_appDomain$_apiVrsion/fingerprint_correction';
  static const String _loanApi = '$_appDomain$_apiVrsion/loan';

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

  ///holiday/add
  static const String addHolidayRequest = '$_holidayApi/add';

  //fingerprint_correction/add
  static const String addFingerPrintCorrection = '$_fingerprintCorrectionApi/add';

  //loan/add
  static const String addloan = '$_loanApi/add';

}

