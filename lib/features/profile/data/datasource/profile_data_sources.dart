import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateProfile(Map<String, dynamic> data);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<void> updateProfile(Map<String, dynamic> data) async {
    await _apiClient.post(ApiEndpoints.login, data: data);
  }
}

class MockProfileRemoteDataSource implements ProfileRemoteDataSource {
  @override
  Future<void> updateProfile(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
