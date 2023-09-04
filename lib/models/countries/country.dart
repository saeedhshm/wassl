import 'package:get/get.dart';

import '../../views/reusable_widgets/drop_down_widget.dart';

class Country  extends DropItem{
  int? id;
  String? code;
  String? nameEn;
  String? nameAr;
  String? nationalityEn;
  String? nationalityAr;

  Country({this.id, this.code, this.nameEn, this.nameAr, this.nationalityEn, this.nationalityAr});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    nationalityEn = json['nationality_en'];
    nationalityAr = json['nationality_ar'];
  }

  @override
  // TODO: implement name
  String get name {
    return ('lang_code'.tr == 'ar' ? nameAr : nameEn) ?? '';
  }

  String get nationality {
    return ('lang_code'.tr == 'ar' ? nationalityAr : nationalityEn) ?? '';
  }

}