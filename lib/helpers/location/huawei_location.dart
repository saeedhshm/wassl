import 'dart:async';

import 'package:flutter/services.dart';
import 'package:huawei_location/huawei_location.dart';
import 'package:wassl/helpers/location/position.dart';

import '../constants/print_ln.dart';

class HuaweiLocationServices {
  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  final LocationRequest _locationRequest = LocationRequest()..interval = 500;
  late LocationSettingsRequest _locationSettingsRequest;

  late StreamSubscription<Location> _streamSubscription;
  int? _requestCode;
  HuaweiLocationServices() {
    _streamSubscription = _locationService.onLocationData!.listen(
      (Location location) {
        println('=-=--=--=-=-> ${location.toString()}');
      },
    );
    _requestLocationUpdates();
    getLastLocation();
  }

  Future<UserPosition> getLastLocation() async {
    try {
      println('location1.toString()');
      _locationSettingsRequest = LocationSettingsRequest(
          requests: <LocationRequest>[_locationRequest]);
      final Location location = await _locationService.getLastLocation();
      println(location.toString());

      return UserPosition(
          latitude: location.latitude ?? 0.0,
          longitude: location.longitude ?? 0.0);
    } catch (e) {
      rethrow;
    } finally {
      _removeLocationUpdates();
    }
  }

  void _requestLocationUpdates() async {
    if (_requestCode == null) {
      try {
        final int requestCode = (await (_locationService
            .requestLocationUpdates(_locationRequest)))!;
        _requestCode = requestCode;
        println('Location updates requested successfully');
      } on PlatformException catch (e) {
        println(e.toString());
      }
    } else {
      println(
        'Already requested location updates. Try removing location updates',
      );
    }
  }

  void _removeLocationUpdates() async {
    if (_requestCode != null) {
      try {
        await _locationService.removeLocationUpdates(_requestCode!);
        _requestCode = null;
        _streamSubscription.cancel();
        println('Location updates are removed successfully');
      } on PlatformException catch (e) {
        println(e.toString());
      }
    } else {
      println('requestCode does not exist. Request location updates first');
    }
  }
}
