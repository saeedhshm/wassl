// https://waslhr.com/public/file/uOpBCDJRcQjVW1DJ7PbZqmRMvmywL4EcMIQRtJzb.pdf
class AppUrls {
  static String appDomain = 'https://waslhr.com';

// String appDomain = 'https://dev.waslhr-test.com';
// String appDomain = 'https://wasl.trafficksa.com';

// String appDomain =  'https://waslhr-test.com';

  static String get apiVrsion => '$appDomain/api/v1';

  static String get _authApi => '$apiVrsion/auth';
  static String get _assignApi => '$apiVrsion/assign';
  static String get _attendanceApi => '$apiVrsion/attendance';
  static String get _ordersApi => '$apiVrsion/orders';
  static String get _holidayApi => '$apiVrsion/holiday';
  static String get _fingerprintCorrectionApi =>
      '$apiVrsion/fingerprint_correction';
  static String get _loanApi => '$apiVrsion/loan';
  static String get _letterApi => '$apiVrsion/letter';
  static String get _askPermissionApi => '$apiVrsion/ask_permission';
  static String get _financialExpensesApi => '$apiVrsion/financial_expenses';
  static String get _custodyApi => '$apiVrsion/custody';
  static String get _visaApi => '$apiVrsion/visa';
  static String get _overtimeApi => '$apiVrsion/overtime';

  //https://waslhr.com/api/v1/auth
  static String get login => '$_authApi/login';
  static String get logout => '$_authApi/logout';
  static String get changePassword => '$_authApi/save_my_password';
  static String get updateToken => '$_authApi/update_token';

  //https://waslhr.com/api/v1/assign
  static String get _attendance => '$_assignApi/attendance';
  static String get _leaving => '$_assignApi/leave';

  static String registerAttendance(int attendanceStatus) {
    if (attendanceStatus == 2) {
      return AppUrls._leaving;
    } else {
      return AppUrls._attendance;
    }
  }

  static String get monthlyAttendance => '$_attendanceApi/month_v2';

  static String get attendanceCheck {
    // if(appDomain.contains('wasl.trafficksa')){
    return '$_assignApi/check_v2';
    // }
    // return '$_assignApi/check';
  }

  static String get teamAttendanceApi {
    return '$apiVrsion/team_attendance_v2';
  }

  ///orders/get
  static String get getAllOrders => '$_ordersApi/get';
  //{{domain}}/orders/get-team-orders
  static String get getTeamOrders => '$_ordersApi/get-team-orders';
  static String get setTeamOrderSatus => '$_ordersApi/set-team-order-status';

  //{{domain}}/get_holiday_types
  static String get getHolidayTypes => '$apiVrsion/get_holiday_types';
  //{{domain}}/vacations
  static String get getVacations => '$apiVrsion/vacations';

  ///holiday/add
  static String get addHolidayRequest => '$_holidayApi/add';
  //{{domain}}/holiday/update/22
  static String get updateHolidayRequest => '$_holidayApi/update';
  //{{domain}}/holiday/cancel/9
  static String get cancelHolidayRequest => '$_holidayApi/cancel';

  //fingerprint_correction/add
  static String get addFingerPrintCorrection =>
      '$_fingerprintCorrectionApi/add';
//{{domain}}/fingerprint_correction/cancel/8
  static String get cancelFingerPrintCorrection =>
      '$_fingerprintCorrectionApi/cancel';
  //{{domain}}/fingerprint_correction/update/5
  static String get updateFingerPrintCorrection =>
      '$_fingerprintCorrectionApi/update';

  //{{domain}}/get_loan_types
  static String get getLoansTypes => '$apiVrsion/get_loan_types';
  //loan/add
  static String get addLoan => '$_loanApi/add';
  //{{domain}}/loan/update/7
  static String get updateLoan => '$_loanApi/update';
  // {{domain}}/loan/cancel/9
  static String get cancelLoan => '$_loanApi/cancel';

  //{{domain}}/get_letter_types
  static String get getLetterTypes => '$apiVrsion/get_letter_types';
  //{{domain}}/letter/add
  static String get addLetter => '$_letterApi/add';
  // {{domain}}/letter/update/5
  static String get updateLetter => '$_letterApi/update';
  //{{domain}}/letter/cancel/7
  static String get cancelLetter => '$_letterApi/cancel';

  //{{domain}}/get_ask_permission_types
  static String get getPermissionsTypes =>
      '$apiVrsion/get_ask_permission_types';
  //{{domain}}/ask_permission/add
  static String get addPermission => '$_askPermissionApi/add';
  // {{domain}}/ask_permission/cancel/9
  static String get cancelPermission => '$_askPermissionApi/cancel';
  //{{domain}}/ask_permission/update/7
  static String get updatePermission => '$_askPermissionApi/update';

  //{{domain}}/financial_expenses/add
  static String get addFinancialExpenses => '$_financialExpensesApi/add';
  //{{domain}}/financial_expenses/update/4
  static String get updateFinancialExpenses => '$_financialExpensesApi/update';
  // {{domain}}/financial_expenses/cancel/6
  static String get cancelFinancialExpenses => '$_financialExpensesApi/cancel';

  //{{domain}}/get_custody_types
  static String get getCustodyTypes => '$apiVrsion/get_custody_types';
  //{{domain}}/custody/add
  static String get addCustody => '$_custodyApi/add';
  //{{domain}}/custody/cancel/3
  static String get cancelCustody => '$_custodyApi/cancel';
  //{{domain}}/custody/update/3
  static String get updateCustody => '$_custodyApi/update';

  //{{domain}}/get_ticket_types
  static String get getTicketTypes => '$apiVrsion/get_ticket_types';
  //{{domain}}/get_visa_time
  static String get getVisaTime => '$apiVrsion/get_visa_time';
//{{domain}}/get_visa_types
  static String get getVisaTypes => '$apiVrsion/get_visa_types';
  //{{domain}}/visa/add
  static String get addVisa => '$_visaApi/add';
  //{{domain}}/visa/update/3
  static String get updateVisa => '$_visaApi/update';
  //{{domain}}/visa/cancel/3
  static String get cancelVisa => '$_visaApi/cancel';

  //{{domain}}/overtime/add
  static String get addOvertimeApi => '$_overtimeApi/add';
  //{{domain}}/overtime/update/2
  static String get updateOvertimeApi => '$_overtimeApi/update';
  // {{domain}}/overtime/cancel/2
  static String get cancelOvertimeApi => '$_overtimeApi/cancel';

  //https://waslhr.com/api/v1/documents
  static String get documentsApi => '$apiVrsion/documents';
  //https://waslhr.com/api/v1/covenant
  static String get covenantApi => '$apiVrsion/covenant';
  // {{domain}}/vacations
  static String get vacationsApi => '$apiVrsion/vacations';

  // {{domain}}/SalaryDetails/14
  static String get salaryDetailsApi => '$apiVrsion/SalaryDetails';
  // {{domain}}/SalaryMonth/14
  static String get salaryMonthsApi => '$apiVrsion/SalaryMonth';
  //{{domain}}/ads
  static String get adsApi => '$apiVrsion/ads';
  //{{domain}}/meetings
  static String get meetingsApi => '$apiVrsion/meetings';

  //tabreer
  // {{domain}}/get_tabrir_types
  static String get tabreerTypesApi {
    return '$apiVrsion/get_tabrir_types';
  }

  //{{domain}}/tabrir/add
  static String get addTabreerApi {
    return '$apiVrsion/tabrir/add';
  }

  //{{domain}}/tabrir/edit/23
  //{{domain}}/tabrir/update/22
  static String get updateTabreerApi {
    return '$apiVrsion/tabrir/update';
  }

  //{{domain}}/tabrir/cancel/10
  static String get cancelTabreerApi {
    return '$apiVrsion/tabrir/cancel';
  }
}
