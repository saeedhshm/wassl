
class Covenant {
  int? id;
  int? employeeId;
  String? name;
  String? type;
  String? receivedDate;
  String? evictionDate;
  String? status;
  String? description;
  String? createdAt;
  String? updatedAt;

  Covenant(
      {this.id,
        this.employeeId,
        this.name,
        this.type,
        this.receivedDate,
        this.evictionDate,
        this.status,
        this.description,
        this.createdAt,
        this.updatedAt});

  Covenant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    name = json['name'];
    type = json['type'];
    receivedDate = json['received_date'];
    evictionDate = json['eviction_date'];
    status = json['status'];
    description = json['descrition'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}