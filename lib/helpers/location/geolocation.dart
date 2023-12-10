import 'package:geolocator/geolocator.dart';
import 'package:wassl/helpers/location/position.dart';

class MyGeoLocation {
  Future<UserPosition> returnUserLocationposition() async {
    var p = await Geolocator.getCurrentPosition();

    return UserPosition(latitude: p.latitude, longitude: p.longitude);
  }
}
