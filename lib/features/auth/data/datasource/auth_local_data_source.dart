import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassl/core/constants/app_constants.dart';
import 'package:wassl/features/auth/data/datasource/auth_data_sources.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;

  AuthLocalDataSourceImpl(this._prefs);

  @override
  Future<void> saveCredentials(String email, String password) async {
    await _prefs.setString(AppConstants.appStorageEmail, email);
    await _prefs.setString(AppConstants.appStoragePassword, password);
  }

  @override
  Future<Map<String, String>> getSavedCredentials() async {
    final email = _prefs.getString(AppConstants.appStorageEmail);
    final password = _prefs.getString(AppConstants.appStoragePassword);
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return {};
  }

  @override
  Future<void> clearCredentials() async {
    await _prefs.remove(AppConstants.appStorageEmail);
    await _prefs.remove(AppConstants.appStoragePassword);
  }

  @override
  Future<void> saveToken(String token) async {
    await _prefs.setString('auth_token', token);
  }

  @override
  String? getToken() => _prefs.getString('auth_token');

  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _prefs.setString('user_data', userData.toString());
  }

  @override
  Map<String, dynamic>? getUserData() {
    final data = _prefs.getString('user_data');
    if (data == null) return null;
    return {};
  }

  @override
  Future<void> clearAll() async {
    await _prefs.remove('auth_token');
    await _prefs.remove('user_data');
    await clearCredentials();
  }
}
