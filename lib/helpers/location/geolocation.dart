import 'package:geolocator/geolocator.dart';

import '../exceptions/location_exceptions.dart';

class MyGeoLocation {
  // Future getMyLocation() async {
  //   position  = await _determinePosition();
  //
  //   println('=--=-=-=-=-=-=-=-=-=- position ----');
  //   println(position);
  //   println('=--=-=-=-=-=-=-=-=-=- position ----');
  //
  // }
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<LocationPermission> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    // listOfErrors.add('enter determinePosition');
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // listOfErrors.add('serviceEnabled is false');
      throw LocationDisabledException();
      // return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    // return Future.error('Location permissions are denied');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationDeniedException();
        // return permission;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationDisabledException();
      // return permission;
    }

    // var deviceData = await initPlatformState();
    // if (deviceData['brand'] == 'Huawei') {
    //   position = await huaweiLocationServices.getLastLocation();
    //   // println(position.toString());
    // } else {
    //   try {
    //     var p = await Geolocator.getCurrentPosition();
    //     position = AppPosition(latitude: p.latitude, longitude: p.longitude);
    //   } catch (e) {}
    // }

    return permission;
  }
}
