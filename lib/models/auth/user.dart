import 'package:get/get.dart';


class User {
  int? id;
  int? jobId;
  int? companyId;
  int? branchId;
  int? nationalityId;
  dynamic photo;
  String? code;
  String? _fullName;
  int? status;
  int? gender;
  String? dateOfBirth;
  String? dateOfJoining;
  String? number;
  dynamic qualification;
  dynamic emergencyNumber;
  dynamic panNumber;
  String? _fullNameEn;
  String? currentAddress;
  String? permanentAddress;
  dynamic formalities;
  dynamic offerAcceptance;
  dynamic probationPeriod;
  dynamic dateOfConfirmation;
  int? departmentId;
  String? salary;
  dynamic accountNumber;
  dynamic bankName;
  dynamic unNumber;
  dynamic dateOfResignation;
  dynamic noticePeriod;
  dynamic lastWorkingDay;
  int? fullFinal;
  String? createdAt;
  String? updatedAt;

  String? nationalityNumber;
  String? email;
  String? typeId;
  int? isActive;
  int? stop;
  String? fcmToken;
  Schedule? schedule;
  Branch? branch;
  Branch? job;

  User(
      {this.id,
        this.jobId,
        this.companyId,
        this.branchId,
        this.nationalityId,
        this.photo,
        this.code,

        this.status,
        this.gender,
        this.dateOfBirth,
        this.dateOfJoining,
        this.number,
        this.qualification,
        this.emergencyNumber,
        this.panNumber,

        this.currentAddress,
        this.permanentAddress,
        this.formalities,
        this.offerAcceptance,
        this.probationPeriod,
        this.dateOfConfirmation,
        this.departmentId,
        this.salary,
        this.accountNumber,
        this.bankName,
        this.unNumber,
        this.dateOfResignation,
        this.noticePeriod,
        this.lastWorkingDay,
        this.fullFinal,
        this.createdAt,
        this.updatedAt,
        this.nationalityNumber,
        this.email,
        this.typeId,
        this.isActive,
        this.stop,
        this.fcmToken,
        this.schedule,
        this.branch,
        this.job});



  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    companyId = json['company_id'];
    branchId = json['branch_id'];
    nationalityId = json['nationality_id'];
    photo = json['photo'];
    code = json['code'];
    _fullName = json['full_name'];
    status = json['status'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    dateOfJoining = json['date_of_joining'];
    number = json['number'];
    qualification = json['qualification'];
    emergencyNumber = json['emergency_number'];
    panNumber = json['pan_number'];
    _fullNameEn = json['full_name_en'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    formalities = json['formalities'];
    offerAcceptance = json['offer_acceptance'];
    probationPeriod = json['probation_period'];
    dateOfConfirmation = json['date_of_confirmation'];
    departmentId = json['department_id'];
    salary = json['salary'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    unNumber = json['un_number'];
    dateOfResignation = json['date_of_resignation'];
    noticePeriod = json['notice_period'];
    lastWorkingDay = json['last_working_day'];
    fullFinal = json['full_final'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nationalityNumber = json['nationality_number'];
    email = json['email'];
    typeId = json['type_id'];
    isActive = json['is_active'];
    stop = json['stop'];
    fcmToken = json['fcm_token'];
    schedule = json['schedule'] != null
        ?  Schedule.fromJson(json['schedule'])
        : null;
    branch =
    json['branch'] != null ?  Branch.fromJson(json['branch']) : null;
    job = json['job'] != null ?  Branch.fromJson(json['job']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['company_id'] = this.companyId;
    data['branch_id'] = this.branchId;
    data['nationality_id'] = this.nationalityId;
    data['photo'] = this.photo;
    data['code'] = this.code;
    data['full_name'] = this._fullName;
    data['status'] = this.status;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['date_of_joining'] = this.dateOfJoining;
    data['number'] = this.number;
    data['qualification'] = this.qualification;
    data['emergency_number'] = this.emergencyNumber;
    data['pan_number'] = this.panNumber;
    data['full_name_en'] = this._fullNameEn;
    data['current_address'] = this.currentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['formalities'] = this.formalities;
    data['offer_acceptance'] = this.offerAcceptance;
    data['probation_period'] = this.probationPeriod;
    data['date_of_confirmation'] = this.dateOfConfirmation;
    data['department_id'] = this.departmentId;
    data['salary'] = this.salary;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['un_number'] = this.unNumber;
    data['date_of_resignation'] = this.dateOfResignation;
    data['notice_period'] = this.noticePeriod;
    data['last_working_day'] = this.lastWorkingDay;
    data['full_final'] = this.fullFinal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nationality_number'] = this.nationalityNumber;
    data['email'] = this.email;
    data['type_id'] = this.typeId;
    data['is_active'] = this.isActive;
    data['stop'] = this.stop;
    data['fcm_token'] = this.fcmToken;
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    return data;
  }

  String get fullName{
    return ('lang_code'.tr == 'ar' ? _fullName : _fullNameEn) ?? '';
  }

}

class Schedule {
  int? id;
  int? employeeId;
  int? scheduleId;
  int? minuteTimeOut;
  int? minuteTimeIn;
  String? allowTimeOut;
  String? allowTimeIn;
  Info? info;

  Schedule(
      {this.id,
        this.employeeId,
        this.scheduleId,
        this.minuteTimeOut,
        this.minuteTimeIn,
        this.allowTimeOut,
        this.allowTimeIn,
        this.info});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    scheduleId = json['schedule_id'];
    minuteTimeOut = json['minute_time_out'];
    minuteTimeIn = json['minute_time_in'];
    allowTimeOut = json['allow_time_out'] ?? '00:40:00';
    allowTimeIn = json['allow_time_in'];
    info = json['info'] != null ?  Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['schedule_id'] = this.scheduleId;
    data['minute_time_out'] = this.minuteTimeOut;
    data['minute_time_in'] = this.minuteTimeIn;
    data['allow_time_out'] = this.allowTimeOut;
    data['allow_time_in'] = this.allowTimeIn;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}


class Info {
  int? id;
  int? companyId;
  int? type;
  String? slug;
  String? weekEndDays;
  String? timeIn;
  String? timeOut;

  Info(
      {this.id,
        this.companyId,
        this.type,
        this.slug,
        this.weekEndDays,
        this.timeIn,
        this.timeOut});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    type = json['type'];
    slug = json['slug'];
    weekEndDays = json['week_end_days'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['week_end_days'] = this.weekEndDays;
    data['time_in'] = this.timeIn;
    data['time_out'] = this.timeOut;
    return data;
  }
}

class Branch {
  int? id;
  int? companyId;
  String? _nameAr;
  String? _nameEn;
  String? createdAt;
  String? updatedAt;

  // Branch(
  //     {this.id,
  //       this.companyId,
  //       this.nameAr,
  //       this.nameEn,
  //       this.createdAt,
  //       this.updatedAt});

  Branch.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    companyId = json['company_id'];
    _nameAr = json['name_ar'];
    _nameEn = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['name_ar'] = this._nameAr;
    data['name_en'] = this._nameEn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  
  String get name{
    return ('lang_code'.tr == 'ar' ? _nameAr  : _nameEn) ?? '';
  }
}