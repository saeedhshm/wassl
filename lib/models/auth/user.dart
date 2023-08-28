import 'package:get/get.dart';
import 'package:wassl/models/auth/schedule.dart';


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
  List<Schedule>?  allSchedules = <Schedule>[];
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
        this.allSchedules,
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
    if (json['all_schedules'] != null) {
      json['all_schedules'].forEach((v) {
        allSchedules!.add(Schedule.fromJson(v));
      });
    }
    schedule = json['schedule'] != null
        ?  Schedule.fromJson(json['schedule'])
        : null;
    branch =
    json['branch'] != null ?  Branch.fromJson(json['branch']) : null;
    job = json['job'] != null ?  Branch.fromJson(json['job']) : null;
  }


  String get fullName{
    return ('lang_code'.tr == 'ar' ? _fullName : _fullNameEn) ?? '';
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

  
  String get name{
    return ('lang_code'.tr == 'ar' ? _nameAr  : _nameEn) ?? '';
  }
}