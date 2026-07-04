class ApiEndpoints {
  static const String _baseUrl = 'https://waslhr.com';
  static const String apiVersion = '/api/v1';

  static const String baseUrl = '$_baseUrl$apiVersion';

  static const String _auth = '/auth';
  static const String _assign = '/assign';
  static const String _attendance = '/attendance';
  static const String _orders = '/orders';
  static const String _holiday = '/holiday';
  static const String _fingerprintCorrection = '/fingerprint_correction';
  static const String _loan = '/loan';
  static const String _letter = '/letter';
  static const String _askPermission = '/ask_permission';
  static const String _financialExpenses = '/financial_expenses';
  static const String _custody = '/custody';
  static const String _visa = '/visa';
  static const String _overtime = '/overtime';
  static const String _tabrir = '/tabrir';

  static const String login = '$_auth/login';
  static const String logout = '$_auth/logout';
  static const String changePassword = '$_auth/save_my_password';
  static const String updateToken = '$_auth/update_token';
  static const String attendanceCheck = '$_assign/check_v2';
  static const String registerAttendance = '$_assign/attendance';
  static const String registerLeaving = '$_assign/leave';
  static const String monthlyAttendance = '$_attendance/month_v2';
  static const String teamAttendance = '/team_attendance_v2';

  static const String getAllOrders = '$_orders/get';
  static const String getTeamOrders = '$_orders/get-team-orders';
  static const String setTeamOrderStatus = '$_orders/set-team-order-status';

  static const String getHolidayTypes = '/get_holiday_types';
  static const String getVacations = '/vacations';
  static const String addHolidayRequest = '$_holiday/add';
  static const String updateHolidayRequest = '$_holiday/update';
  static const String cancelHolidayRequest = '$_holiday/cancel';

  static const String addFingerPrintCorrection = '$_fingerprintCorrection/add';
  static const String updateFingerPrintCorrection = '$_fingerprintCorrection/update';
  static const String cancelFingerPrintCorrection = '$_fingerprintCorrection/cancel';

  static const String getLoanTypes = '/get_loan_types';
  static const String addLoan = '$_loan/add';
  static const String updateLoan = '$_loan/update';
  static const String cancelLoan = '$_loan/cancel';

  static const String getLetterTypes = '/get_letter_types';
  static const String addLetter = '$_letter/add';
  static const String updateLetter = '$_letter/update';
  static const String cancelLetter = '$_letter/cancel';

  static const String getPermissionTypes = '/get_ask_permission_types';
  static const String addPermission = '$_askPermission/add';
  static const String updatePermission = '$_askPermission/update';
  static const String cancelPermission = '$_askPermission/cancel';

  static const String addFinancialExpenses = '$_financialExpenses/add';
  static const String updateFinancialExpenses = '$_financialExpenses/update';
  static const String cancelFinancialExpenses = '$_financialExpenses/cancel';

  static const String getCustodyTypes = '/get_custody_types';
  static const String addCustody = '$_custody/add';
  static const String updateCustody = '$_custody/update';
  static const String cancelCustody = '$_custody/cancel';

  static const String getVisaTypes = '/get_visa_types';
  static const String getVisaTime = '/get_visa_time';
  static const String getTicketTypes = '/get_ticket_types';
  static const String addVisa = '$_visa/add';
  static const String updateVisa = '$_visa/update';
  static const String cancelVisa = '$_visa/cancel';

  static const String getTabreerTypes = '/get_tabrir_types';
  static const String addTabreer = '$_tabrir/add';
  static const String updateTabreer = '$_tabrir/update';
  static const String cancelTabreer = '$_tabrir/cancel';

  static const String addOvertime = '$_overtime/add';
  static const String updateOvertime = '$_overtime/update';
  static const String cancelOvertime = '$_overtime/cancel';

  static const String documents = '/documents';
  static const String covenant = '/covenant';
  static const String vacationsApi = '/vacations';
  static const String salaryDetails = '/SalaryDetails';
  static const String salaryMonths = '/SalaryMonth';
  static const String ads = '/ads';
  static const String meetings = '/meetings';
  static const String countryAll = '/country-all';
  static const String countryAjax = '/country-ajax';
}
