import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:wassl/helpers/device_info/device_info.dart';

class DeviceInfoChecker {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<DeviceInfo> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        var deviceInfoMap =
            _readAndroidBuildData(await _deviceInfoPlugin.androidInfo);
        return DeviceInfo.fromMap(deviceInfoMap);
      } else if (Platform.isIOS) {
        var deviceInfoMap = _readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
        return DeviceInfo.fromMap(deviceInfoMap);
      } else {
        throw PlatformException(code: '404');
      }
    } on PlatformException {
      // deviceData = <String, dynamic>{
      //   'Error:': 'Failed to get platform version.'
      // };

      rethrow;
    } catch (e) {
      rethrow;
    }

    // if (!mounted) return;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    var androidDeviceInfo = <String, dynamic>{
      // 'version.securityPatch': build.version.securityPatch,
      // 'version.sdkInt': build.version.sdkInt,
      // 'version.previewSdkInt': build.version.previewSdkInt,
      // 'version.incremental': build.version.incremental,
      // 'version.codename': build.version.codename,
      // 'version.baseOS': build.version.baseOS,
      // 'board': build.board,
      // 'bootloader': build.bootloader,
      'brand': build.brand,
      // 'device': build.device,
      // 'display': build.display,
      // 'fingerprint': build.fingerprint,
      // 'hardware': build.hardware,
      // 'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      // 'supported32BitAbis': build.supported32BitAbis,
      // 'supported64BitAbis': build.supported64BitAbis,
      // 'supportedAbis': build.supportedAbis,
      // 'tags': build.tags,
      // 'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      // 'systemFeatures': build.systemFeatures,
      // 'displaySizeInches':
      //     ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      // 'displayWidthPixels': build.displayMetrics.widthPx,
      // 'displayWidthInches': build.displayMetrics.widthInches,
      // 'displayHeightPixels': build.displayMetrics.heightPx,
      // 'displayHeightInches': build.displayMetrics.heightInches,
      // 'displayXDpi': build.displayMetrics.xDpi,
      // 'displayYDpi': build.displayMetrics.yDpi,
      // 'serialNumber': build.serialNumber,
    };

    return androidDeviceInfo;
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    var androidDeviceInfo = <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      // 'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      // 'utsname.sysname:': data.utsname.sysname,
      // 'utsname.nodename:': data.utsname.nodename,
      // 'utsname.release:': data.utsname.release,
      // 'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };

    return androidDeviceInfo;
  }
}
