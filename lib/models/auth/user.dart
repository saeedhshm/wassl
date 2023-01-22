
class User {
  int? id;
  int? jobId;
  int? companyId;
  int? branchId;
  int? nationalityId;
  Null? photo;
  String? code;
  String? fullName;
  int? status;
  int? gender;
  String? dateOfBirth;
  String? dateOfJoining;
  String? number;
  Null? qualification;
  Null? emergencyNumber;
  Null? panNumber;
  String? fullNameEn;
  Null? currentAddress;
  Null? permanentAddress;
  Null? formalities;
  Null? offerAcceptance;
  Null? probationPeriod;
  Null? dateOfConfirmation;
  int? departmentId;
  String? salary;
  Null? accountNumber;
  Null? bankName;
  Null? unNumber;
  Null? dateOfResignation;
  Null? noticePeriod;
  Null? lastWorkingDay;
  int? fullFinal;
  String? createdAt;
  String? updatedAt;
  String? email;
  String? typeId;
  Schedule? schedule;

  User(
      {this.id,
        this.jobId,
        this.companyId,
        this.branchId,
        this.nationalityId,
        this.photo,
        this.code,
        this.fullName,
        this.status,
        this.gender,
        this.dateOfBirth,
        this.dateOfJoining,
        this.number,
        this.qualification,
        this.emergencyNumber,
        this.panNumber,
        this.fullNameEn,
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
        this.email,
        this.typeId,
        this.schedule});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    companyId = json['company_id'];
    branchId = json['branch_id'];
    nationalityId = json['nationality_id'];
    photo = json['photo'];
    code = json['code'];
    fullName = json['full_name'];
    status = json['status'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    dateOfJoining = json['date_of_joining'];
    number = json['number'];
    qualification = json['qualification'];
    emergencyNumber = json['emergency_number'];
    panNumber = json['pan_number'];
    fullNameEn = json['full_name_en'];
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
    email = json['email'];
    typeId = json['type_id'];
    schedule = json['schedule'] != null
        ? new Schedule.fromJson(json['schedule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['company_id'] = this.companyId;
    data['branch_id'] = this.branchId;
    data['nationality_id'] = this.nationalityId;
    data['photo'] = this.photo;
    data['code'] = this.code;
    data['full_name'] = this.fullName;
    data['status'] = this.status;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['date_of_joining'] = this.dateOfJoining;
    data['number'] = this.number;
    data['qualification'] = this.qualification;
    data['emergency_number'] = this.emergencyNumber;
    data['pan_number'] = this.panNumber;
    data['full_name_en'] = this.fullNameEn;
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
    data['email'] = this.email;
    data['type_id'] = this.typeId;
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.toJson();
    }
    return data;
  }
}

class Schedule {
  int? id;
  int? employeeId;
  int? scheduleId;
  Info? info;

  Schedule({this.id, this.employeeId, this.scheduleId, this.info});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    scheduleId = json['schedule_id'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['schedule_id'] = this.scheduleId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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