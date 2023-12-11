import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:wassl/helpers/location/position.dart';

class UserLocationPosition {
  Future<UserPosition> getUserLocationPosition() async {
    try {
      var p = await Geolocator.getCurrentPosition();

      return UserPosition(latitude: p.latitude, longitude: p.longitude);
    } on TimeoutException {
      rethrow;
    } on LocationServiceDisabledException {
      rethrow;
    }
  }
}
