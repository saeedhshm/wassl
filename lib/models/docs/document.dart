
class Document {
  int? id;
  int? employeeId;
  String? name;
  String? evictionDate;
  String? descrition;
  String? file;
  String? createdAt;
  String? updatedAt;

  Document(
      {this.id,
        this.employeeId,
        this.name,
        this.evictionDate,
        this.descrition,
        this.file,
        this.createdAt,
        this.updatedAt});

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    name = json['name'];
    evictionDate = json['eviction_date'];
    descrition = json['descrition'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}