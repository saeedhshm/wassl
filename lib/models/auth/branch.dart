
import 'package:get/get.dart';

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['name_ar'] = _nameAr;
    data['name_en'] = _nameEn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String get name{
    return ('lang_code'.tr == 'ar' ? _nameAr : _nameEn) ?? '';
  }
}