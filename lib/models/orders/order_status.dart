import 'package:get/get.dart';

class Status {
  int? id;
  String? _statusAr;
  String? _statusEn;
  String? createdAt;
  String? updatedAt;

  Status(
      {this.id, this.createdAt, this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    _statusAr = json['status_ar'];
    _statusEn = json['status_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_ar'] = this._statusAr;
    data['status_en'] = this._statusEn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  String get statusAr{
    return ('lang_code'.tr == 'ar' ? _statusAr : _statusEn) ?? '';
  }
}
