class Country {
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

}