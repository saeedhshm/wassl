
class Vacations {
  bool? success;
  VacationDetails? data;
  String? message;

  Vacations({success, data, message});

  Vacations.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? VacationDetails.fromJson(json['data']) : null;
    message = json['message'];
  }

}

class VacationDetails {
  int? id;
  int? employeeId;
  dynamic openingVacationsCount;
  dynamic usedVacationsCount;
  dynamic availableVacationsCount;
  dynamic discountVacationsCount;
  dynamic sickVacationsCount;
  dynamic unpaidVacationsCount;
  dynamic createdAt;
  String? updatedAt;
  List<Vacation> previousVacations = [];
  List<Vacation> nextVacations = [];

  VacationDetails(
      {id,
        employeeId,
        openingVacationsCount,
        usedVacationsCount,
        availableVacationsCount,
        discountVacationsCount,
        sickVacationsCount,
        unpaidVacationsCount,
        createdAt,
        updatedAt,});

  VacationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    openingVacationsCount = json['opening_vacations_count'];
    usedVacationsCount = json['used_vacations_count'];
    availableVacationsCount = json['available_vacations_count'];
    discountVacationsCount = json['discount_vacations_count'];
    sickVacationsCount = json['sick_vacations_count'];
    unpaidVacationsCount = json['unpaid_vacations_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['previous_vacations'] != null) {
      previousVacations = <Vacation>[];
      json['previous_vacations'].forEach((v) {
        previousVacations.add(Vacation.fromJson(v));
      });
    }
    if (json['next_vacations'] != null) {
      nextVacations = <Vacation>[];
      json['next_vacations'].forEach((v) {
        nextVacations.add(Vacation.fromJson(v));
      });
    }
  }

}

class Vacation {
  int? id;
  Type? type;
  String? holidayStart;
  String? holidayEnd;
  int? count;
  String? typeOfOrder;

  Vacation(
      {id,
        type,
        holidayStart,
        holidayEnd,
        count,
        typeOfOrder});

  Vacation.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    if(json['type'] is Map<String, dynamic>) {
      type = json['type'] != null ? Type.fromJson(json['type']) : null;
    }
    holidayStart = json['holiday_start'];
    holidayEnd = json['holiday_end'];
    count = json['count'];
    typeOfOrder = json['type_of_order'];
  }

}

class Type {
  int? id;
  String? name;

  Type({id, name});

  Type.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
  }

}
