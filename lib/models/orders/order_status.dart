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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status_ar'] = _statusAr;
    data['status_en'] = _statusEn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String get statusAr{
    return ('lang_code'.tr == 'ar' ? _statusAr : _statusEn) ?? '';
  }
}
