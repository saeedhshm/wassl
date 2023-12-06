import 'package:flutter/services.dart';
import 'package:huawei_location/huawei_location.dart';
import 'package:wassl/helpers/location/position.dart';

import '../constants/print_ln.dart';

class HuaweiLocationServices {
  final FusedLocationProviderClient _locationService =
      FusedLocationProviderClient();
  final LocationRequest _locationRequest = LocationRequest()..interval = 500;
  late LocationSettingsRequest _locationSettingsRequest;

  HuaweiLocationServices() {
    getLastLocation();
    // _locationSettingsRequest =
    //     LocationSettingsRequest(requests: <LocationRequest>[_locationRequest]);
    // _requestPermission();
  }

  void _checkLocationSettings() async {
    try {
      final LocationSettingsStates states = await _locationService
          .checkLocationSettings(_locationSettingsRequest);

      // debugPrint(states.toString());
    } on PlatformException catch (e) {}
  }

  // TODO: Please implement your own 'Permission Handler'.
  void _requestPermission() async {
    // Huawei Location needs some permissions to work properly.
    // You are expected to handle these permissions to use Huawei Location Demo.

    // You can learn more about the required permissions from our official documentations.
    // https://developer.huawei.com/consumer/en/doc/development/HMS-Plugin-Guides/dev-process-0000001089376648?ha_source=hms1
  }

  Future<AppPosition> getLastLocation() async {
    try {
      final Location location = await _locationService.getLastLocation();
      println(location.toString());
      return AppPosition(
          latitude: location.latitude ?? 0.0,
          longitude: location.longitude ?? 0.0);
    } catch (e) {
      rethrow;
    }
  }
}
