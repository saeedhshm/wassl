import 'Ad.dart';

class AppAds {
  List<AdItem> ads = [];
  AppAds(){
    ads.add(AdItem(
      id: 0,
      title: '',
      dateTime: '',
      details: '',
      image: ''
    ));
  }
}