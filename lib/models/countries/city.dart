import 'package:get/get.dart';

import '../../views/reusable_widgets/drop_down_widget.dart';

class City extends DropItem {
  int? id;
  int? countryId;
  String? nameEn;
  String? nameAr;
  int? status;
  String? createdAt;
  String? updatedAt;

  City();

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  @override
  // TODO: implement name
  String get name => ('lang_code'.tr == 'ar' ? nameAr : nameEn) ?? '';
}
