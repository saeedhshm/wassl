
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['name_ar'] = this._nameAr;
    data['name_en'] = this._nameEn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  String get name{
    return ('lang_code'.tr == 'ar' ? _nameAr : _nameEn) ?? '';
  }
}