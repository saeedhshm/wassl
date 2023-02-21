class Status {
  int? id;
  String? statusAr;
  String? statusEn;
  String? createdAt;
  String? updatedAt;

  Status(
      {this.id, this.statusAr, this.statusEn, this.createdAt, this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusAr = json['status_ar'];
    statusEn = json['status_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_ar'] = this.statusAr;
    data['status_en'] = this.statusEn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
