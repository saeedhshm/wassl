import 'package:geolocator/geolocator.dart';

import 'exceptions.dart';

class LocationPermissionHandler {
  Future<void> checkLocationPermission() async {
    LocationPermission permission;
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw SystemLocationDisabledException();
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      //if loaction permission denied
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw LocationDeniedDisabledException();
    }
  }
}
