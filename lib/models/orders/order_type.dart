import 'package:get/get.dart';
// class OrderType {
//   int? id;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//
//   OrderType({this.id, this.name, this.createdAt, this.updatedAt});
//
//   OrderType.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }



class OrderType {
  int? id;
  String? _nameAr;
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
    _nameAr = json['name_ar'];
    _nameEn = json['name_en'];
    top = json['top'];
    content = json['content'];
    footer = json['footer'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

 String get name{
    return ('lang_code'.tr == 'ar' ? _nameAr : _nameEn) ?? '';
 }

 void set name(value){
   _nameEn = value;
   _nameAr = value;
 }
}
