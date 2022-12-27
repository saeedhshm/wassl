
class User {
  int? id;
  int? userId;
  int? jobId;
  int? companyId;
  int? branchId;
  String? photo;
  String? code;
  String? name;
  int? status;
  int? gender;
  String? dateOfBirth;
  String? dateOfJoining;
  String? number;
  String? qualification;
  String? emergencyNumber;
  String? panNumber;
  String? fatherName;
  String? currentAddress;
  String? permanentAddress;
  int? formalities;
  int? offerAcceptance;
  String? probationPeriod;
  String? dateOfConfirmation;
  String? department;
  String? salary;
  String? accountNumber;
  String? bankName;
  String? unNumber;
  String? dateOfResignation;
  String? noticePeriod;
  String? lastWorkingDay;
  int? fullFinal;
  Null? createdAt;
  Null? updatedAt;
  String? email;
  String? fullName;

  User(
      {this.id,
        this.userId,
        this.jobId,
        this.companyId,
        this.branchId,
        this.photo,
        this.code,
        this.name,
        this.status,
        this.gender,
        this.dateOfBirth,
        this.dateOfJoining,
        this.number,
        this.qualification,
        this.emergencyNumber,
        this.panNumber,
        this.fatherName,
        this.currentAddress,
        this.permanentAddress,
        this.formalities,
        this.offerAcceptance,
        this.probationPeriod,
        this.dateOfConfirmation,
        this.department,
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
        this.fullName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    jobId = json['job_id'];
    companyId = json['company_id'];
    branchId = json['branch_id'];
    photo = json['photo'];
    code = json['code'];
    name = json['name'];
    status = json['status'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    dateOfJoining = json['date_of_joining'];
    number = json['number'];
    qualification = json['qualification'];
    emergencyNumber = json['emergency_number'];
    panNumber = json['pan_number'];
    fatherName = json['father_name'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    formalities = json['formalities'];
    offerAcceptance = json['offer_acceptance'];
    probationPeriod = json['probation_period'];
    dateOfConfirmation = json['date_of_confirmation'];
    department = json['department'];
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
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['job_id'] = jobId;
    data['company_id'] = companyId;
    data['branch_id'] = branchId;
    data['photo'] = photo;
    data['code'] = code;
    data['name'] = name;
    data['status'] = status;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['date_of_joining'] = dateOfJoining;
    data['number'] = number;
    data['qualification'] = qualification;
    data['emergency_number'] = emergencyNumber;
    data['pan_number'] = panNumber;
    data['father_name'] = fatherName;
    data['current_address'] = currentAddress;
    data['permanent_address'] = permanentAddress;
    data['formalities'] = formalities;
    data['offer_acceptance'] = offerAcceptance;
    data['probation_period'] = probationPeriod;
    data['date_of_confirmation'] = dateOfConfirmation;
    data['department'] = department;
    data['salary'] = salary;
    data['account_number'] = accountNumber;
    data['bank_name'] = bankName;
    data['un_number'] = unNumber;
    data['date_of_resignation'] = dateOfResignation;
    data['notice_period'] = noticePeriod;
    data['last_working_day'] = lastWorkingDay;
    data['full_final'] = fullFinal;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['email'] = email;
    data['full_name'] = fullName;
    return data;
  }
}