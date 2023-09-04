import 'package:get/get.dart';

import '../../helpers/constants/print_ln.dart';
import '../../views/reusable_widgets/drop_down_widget.dart';


class OrderType extends DropItem{
  int? id;
  String? nameAr;
  String? _nameEn;
  String? top;
  String? content;
  String? footer;

  int? companyId;
  String? createdAt;
  String? updatedAt;

  OrderType(
      {this.id,

        this.top,
        this.content,
        this.footer,

        this.companyId,
        this.createdAt,
        this.updatedAt});

  OrderType.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    nameAr = json['name_ar'];
    _nameEn = json['name_en'];
    top = json['top'];
    content = json['content'];
    footer = json['footer'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if(json['name'] != null) {
      name = json['name'];
    }

  }

 @override
  String get name{

    return ('lang_code'.tr == 'ar' ? nameAr : _nameEn) ?? '';
 }

 void set name(value){
   _nameEn = value;
   nameAr = value;
 }
}
