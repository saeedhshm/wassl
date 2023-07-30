import 'Ad.dart';



class AppAds {
  bool? success;

  List<AdItem> ads = [];

  AppAds();

  AppAds.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['advertisements'] != null) {

      json['advertisements'].forEach((v) {
        ads.add(AdItem.fromJson(v));
      });
    }
  }


}

