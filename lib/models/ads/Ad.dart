





import 'package:wassl/helpers/extensions/strings_extensions.dart';

import '../../web_services_helper/urls.dart';

class AdItem {
  int? _id;
  String? _title;
  String? _description;
  String? _image;
  int? _status;
  String? _startDate;
  String? _endDate;
  String? _createdAt;
  String? _updatedAt;
  Pivot? _pivot;


  // int? id;
  // String? image, title, dateTime, details;
  int? get id => _id;

  String? get title => _title;

  String? get details => _description;

  String get image {
    var img = "${AppUrls.appDomain}/$_image";

    return img;
  }

  int? get status => _status;

  String? get dateTime => _startDate?.dateFromTZone;

  String? get endDate => _endDate;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Pivot? get pivot => _pivot;


  AdItem.fromJson(Map<String, dynamic> json) {

    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _status = json['status'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }


}

class Pivot {
  int? _companyEmployeesId;
  int? _advertisementId;



  int? get companyEmployeesId => _companyEmployeesId;
  set companyEmployeesId(int? companyEmployeesId) =>
      _companyEmployeesId = companyEmployeesId;
  int? get advertisementId => _advertisementId;
  set advertisementId(int? advertisementId) =>
      _advertisementId = advertisementId;

  Pivot.fromJson(Map<String, dynamic> json) {
    _companyEmployeesId = json['company_employees_id'];
    _advertisementId = json['advertisement_id'];
  }


}
