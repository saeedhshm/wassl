

const String _appDomain = 'https://waslhr.com';
const String _apiVrsion = '/api/v1';
class AppUrls {

  static const String _authApi = '$_appDomain$_apiVrsion/auth';
  static const String _assignApi = '$_appDomain$_apiVrsion/assign';
  static const String _attendanceApi = '$_appDomain$_apiVrsion/attendance';

  //https://waslhr.com/api/v1/auth
  static const String login = '$_authApi/login';
  static const String logout = '$_authApi/logout';
  static const String changePassword = '$_authApi/save_my_password';

  //https://waslhr.com/api/v1/assign
  static const String attendance = '$_assignApi/attendance';
  static const String leaving = '$_assignApi/leave';
  static const String attendanceCheck = '$_assignApi/check';

  //attendance
  static const String monthlyAttendance = '$_attendanceApi/month';
}

