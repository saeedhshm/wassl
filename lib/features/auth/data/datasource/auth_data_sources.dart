import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseEntity> login(String email, String password);
  Future<void> logout();
  Future<void> changePassword(String currentPassword, String newPassword, String confirmPassword);
  Future<void> updateFcmToken(String token);
}

abstract class AuthLocalDataSource {
  Future<void> saveCredentials(String email, String password);
  Future<Map<String, String>> getSavedCredentials();
  Future<void> clearCredentials();
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> saveUserData(Map<String, dynamic> userData);
  Map<String, dynamic>? getUserData();
  Future<void> clearAll();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LoginResponseEntity> login(String email, String password) async {
    final response = await _apiClient.post(ApiEndpoints.login, data: {
      'email': email,
      'password': password,
    });
    final json = response.data as Map<String, dynamic>;
    return LoginResponseEntity.fromJson(json);
  }

  @override
  Future<void> logout() async {
    await _apiClient.get(ApiEndpoints.logout);
  }

  @override
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    await _apiClient.post(ApiEndpoints.changePassword, data: {
      'currentPassword': currentPassword,
      'password': newPassword,
      'confirmPassword': newPassword,
    });
  }

  @override
  Future<void> updateFcmToken(String token) async {
    await _apiClient.post(ApiEndpoints.updateToken, data: {'token': token});
  }
}
