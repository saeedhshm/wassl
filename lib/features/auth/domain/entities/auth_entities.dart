class UserEntity {
  final int id;
  final int? jobId;
  final int? companyId;
  final int? branchId;
  final int? nationalityId;
  final String? photo;
  final String? code;
  final String fullName;
  final String fullNameEn;
  final int? status;
  final int? gender;
  final String? dateOfBirth;
  final String? dateOfJoining;
  final String? number;
  final String? email;
  final String? salary;
  final String? fcmToken;
  final int? isExemptFingerprinting;
  final String? nationalityNumber;
  final String? typeId;
  final int? isActive;
  final int? stop;
  final int? departmentId;
  final List<ScheduleEntity> schedules;
  final ScheduleEntity? schedule;
  final BranchEntity? branch;
  final BranchEntity? job;

  const UserEntity({
    required this.id,
    this.jobId,
    this.companyId,
    this.branchId,
    this.nationalityId,
    this.photo,
    this.code,
    required this.fullName,
    required this.fullNameEn,
    this.status,
    this.gender,
    this.dateOfBirth,
    this.dateOfJoining,
    this.number,
    this.email,
    this.salary,
    this.fcmToken,
    this.isExemptFingerprinting,
    this.nationalityNumber,
    this.typeId,
    this.isActive,
    this.stop,
    this.departmentId,
    this.schedules = const [],
    this.schedule,
    this.branch,
    this.job,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as int? ?? 0,
      jobId: json['jobId'] as int? ?? json['job_id'] as int?,
      companyId: json['companyId'] as int? ?? json['company_id'] as int?,
      branchId: json['branchId'] as int? ?? json['branch_id'] as int?,
      nationalityId: json['nationalityId'] as int? ?? json['nationality_id'] as int?,
      photo: json['photo']?.toString(),
      code: json['code']?.toString(),
      fullName: json['fullName']?.toString() ?? json['name']?.toString() ?? '',
      fullNameEn: json['fullNameEn']?.toString() ?? json['name_en']?.toString() ?? json['fullName']?.toString() ?? '',
      status: json['status'] as int?,
      gender: json['gender'] as int?,
      dateOfBirth: json['dateOfBirth']?.toString() ?? json['date_of_birth']?.toString(),
      dateOfJoining: json['dateOfJoining']?.toString() ?? json['date_of_joining']?.toString(),
      number: json['number']?.toString(),
      email: json['email']?.toString(),
      salary: json['salary']?.toString(),
      fcmToken: json['fcmToken']?.toString() ?? json['fcm_token']?.toString(),
      isExemptFingerprinting: json['isExemptFingerprinting'] as int? ?? json['is_exempt_fingerprinting'] as int?,
      nationalityNumber: json['nationalityNumber']?.toString() ?? json['nationality_number']?.toString(),
      typeId: json['typeId']?.toString() ?? json['type_id']?.toString(),
      isActive: json['isActive'] as int? ?? json['is_active'] as int?,
      stop: json['stop'] as int?,
      departmentId: json['departmentId'] as int? ?? json['department_id'] as int?,
      schedule: json['schedule'] != null ? ScheduleEntity.fromJson(json['schedule']) : null,
      branch: json['branch'] != null ? BranchEntity.fromJson(json['branch']) : null,
      job: json['job'] != null ? BranchEntity.fromJson(json['job']) : null,
    );
  }
}

class ScheduleEntity {
  final int? id;
  final int? employeeId;
  final int? scheduleId;
  final int? minuteTimeOut;
  final int? minuteTimeIn;
  final String? allowTimeOut;
  final String? allowTimeIn;
  final ScheduleInfoEntity? info;

  const ScheduleEntity({
    this.id,
    this.employeeId,
    this.scheduleId,
    this.minuteTimeOut,
    this.minuteTimeIn,
    this.allowTimeOut,
    this.allowTimeIn,
    this.info,
  });

  factory ScheduleEntity.fromJson(Map<String, dynamic> json) {
    return ScheduleEntity(
      id: json['id'] as int?,
      employeeId: json['employeeId'] as int? ?? json['employee_id'] as int?,
      scheduleId: json['scheduleId'] as int? ?? json['schedule_id'] as int?,
      minuteTimeOut: json['minuteTimeOut'] as int? ?? json['minute_time_out'] as int?,
      minuteTimeIn: json['minuteTimeIn'] as int? ?? json['minute_time_in'] as int?,
      allowTimeOut: json['allowTimeOut']?.toString() ?? json['allow_time_out']?.toString(),
      allowTimeIn: json['allowTimeIn']?.toString() ?? json['allow_time_in']?.toString(),
      info: json['info'] != null ? ScheduleInfoEntity.fromJson(json['info']) : null,
    );
  }
}

class ScheduleInfoEntity {
  final int? id;
  final int? companyId;
  final int? type;
  final String? slug;
  final String? weekEndDays;
  final String? timeIn;
  final String? timeOut;

  const ScheduleInfoEntity({
    this.id,
    this.companyId,
    this.type,
    this.slug,
    this.weekEndDays,
    this.timeIn,
    this.timeOut,
  });

  factory ScheduleInfoEntity.fromJson(Map<String, dynamic> json) {
    return ScheduleInfoEntity(
      id: json['id'] as int?,
      companyId: json['companyId'] as int? ?? json['company_id'] as int?,
      type: json['type'] as int?,
      slug: json['slug']?.toString(),
      weekEndDays: json['weekEndDays']?.toString() ?? json['week_end_days']?.toString(),
      timeIn: json['timeIn']?.toString() ?? json['time_in']?.toString(),
      timeOut: json['timeOut']?.toString() ?? json['time_out']?.toString(),
    );
  }
}

class BranchEntity {
  final int? id;
  final int? companyId;
  final String nameAr;
  final String nameEn;

  const BranchEntity({
    this.id,
    this.companyId,
    required this.nameAr,
    required this.nameEn,
  });

  factory BranchEntity.fromJson(Map<String, dynamic> json) {
    return BranchEntity(
      id: json['id'] as int?,
      companyId: json['companyId'] as int? ?? json['company_id'] as int?,
      nameAr: json['nameAr']?.toString() ?? json['name_ar']?.toString() ?? '',
      nameEn: json['nameEn']?.toString() ?? json['name_en']?.toString() ?? '',
    );
  }
}

class LoginResponseEntity {
  final bool? success;
  final TokenEntity? token;
  final UserEntity? user;

  const LoginResponseEntity({this.success, this.token, this.user});

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    return LoginResponseEntity(
      success: json['success'] as bool?,
      token: json['token'] != null ? TokenEntity.fromJson(json['token']) : null,
      user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
    );
  }
}

class TokenEntity {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;

  const TokenEntity({this.accessToken, this.tokenType, this.expiresIn});

  factory TokenEntity.fromJson(Map<String, dynamic> json) {
    return TokenEntity(
      accessToken: json['accessToken']?.toString() ?? json['access_token']?.toString(),
      tokenType: json['tokenType']?.toString() ?? json['token_type']?.toString(),
      expiresIn: json['expiresIn'] as int? ?? json['expires_in'] as int?,
    );
  }
}
