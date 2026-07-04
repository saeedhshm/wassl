import 'package:wassl/core/error/exceptions.dart';
import 'package:wassl/core/network/api_client.dart';
import 'package:wassl/core/network/api_endpoints.dart';
import 'package:wassl/features/auth/data/datasource/auth_data_sources.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LoginResponseEntity> login(String email, String password) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      return _parseLoginResponse(data);
    }
    throw ServerException(
      message: response.statusMessage ?? 'Login failed',
      statusCode: response.statusCode,
    );
  }

  @override
  Future<void> logout() async {
    final response = await _apiClient.get(ApiEndpoints.logout);
    if (response.statusCode != 200) {
      throw ServerException(message: 'Logout failed', statusCode: response.statusCode);
    }
  }

  @override
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    final response = await _apiClient.post(
      ApiEndpoints.changePassword,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_confirm_password': confirmPassword,
      },
    );
    if (response.statusCode != 200) {
      throw ServerException(message: 'Password change failed', statusCode: response.statusCode);
    }
  }

  @override
  Future<void> updateFcmToken(String token) async {
    await _apiClient.post(ApiEndpoints.updateToken, data: {'fcm_token': token});
  }

  LoginResponseEntity _parseLoginResponse(Map<String, dynamic> json) {
    final token = json['token'] != null ? TokenEntity(
      accessToken: json['token']['access_token']?.toString(),
      tokenType: json['token']['token_type']?.toString(),
      expiresIn: json['token']['expires_in'] as int?,
    ) : null;

    final user = json['user'] != null ? _parseUser(json['user']) : null;

    return LoginResponseEntity(
      success: json['success'] as bool?,
      token: token,
      user: user,
    );
  }

  UserEntity _parseUser(Map<String, dynamic> json) {
    final schedules = (json['all_schedules'] as List<dynamic>?)
        ?.map((e) => _parseSchedule(e as Map<String, dynamic>))
        .toList() ?? [];

    return UserEntity(
      id: json['id'] as int,
      jobId: json['job_id'] as int?,
      companyId: json['company_id'] as int?,
      branchId: json['branch_id'] as int?,
      nationalityId: json['nationality_id'] as int?,
      photo: json['photo']?.toString(),
      code: json['code']?.toString(),
      fullName: json['full_name']?.toString() ?? json['_full_name']?.toString() ?? '',
      fullNameEn: json['full_name_en']?.toString() ?? json['_full_name_en']?.toString() ?? '',
      status: json['status'] as int?,
      gender: json['gender'] as int?,
      dateOfBirth: json['date_of_birth']?.toString(),
      dateOfJoining: json['date_of_joining']?.toString(),
      number: json['number']?.toString(),
      email: json['email']?.toString(),
      salary: json['salary']?.toString(),
      fcmToken: json['fcm_token']?.toString(),
      isExemptFingerprinting: json['is_exempt_fingerprinting'] as int?,
      nationalityNumber: json['nationality_number']?.toString(),
      typeId: json['type_id']?.toString(),
      isActive: json['is_active'] as int?,
      stop: json['stop'] as int?,
      departmentId: json['department_id'] as int?,
      schedules: schedules,
      schedule: json['schedule'] != null
          ? _parseSchedule(json['schedule'] as Map<String, dynamic>)
          : null,
      branch: json['branch'] != null
          ? BranchEntity(
              id: json['branch']['id'] as int?,
              companyId: json['branch']['company_id'] as int?,
              nameAr: json['branch']['_name_ar']?.toString() ?? '',
              nameEn: json['branch']['_name_en']?.toString() ?? '',
            )
          : null,
      job: json['job'] != null
          ? BranchEntity(
              id: json['job']['id'] as int?,
              companyId: json['job']['company_id'] as int?,
              nameAr: json['job']['_name_ar']?.toString() ?? '',
              nameEn: json['job']['_name_en']?.toString() ?? '',
            )
          : null,
    );
  }

  ScheduleEntity _parseSchedule(Map<String, dynamic> json) {
    return ScheduleEntity(
      id: json['id'] as int?,
      employeeId: json['employee_id'] as int?,
      scheduleId: json['schedule_id'] as int?,
      minuteTimeOut: json['minute_time_out'] as int?,
      minuteTimeIn: json['minute_time_in'] as int?,
      allowTimeOut: json['allow_time_out']?.toString(),
      allowTimeIn: json['allow_time_in']?.toString(),
      info: json['info'] != null
          ? ScheduleInfoEntity(
              id: json['info']['id'] as int?,
              companyId: json['info']['company_id'] as int?,
              type: json['info']['type'] as int?,
              slug: json['info']['slug']?.toString(),
              weekEndDays: json['info']['week_end_days']?.toString(),
              timeIn: json['info']['time_in']?.toString(),
              timeOut: json['info']['time_out']?.toString(),
            )
          : null,
    );
  }
}
