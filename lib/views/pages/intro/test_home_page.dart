import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../../getx_controllers/calendar/calendar_controller.dart';
import '../../../getx_controllers/home/home_controller.dart';
import '../../../helpers/exceptions/location_exceptions.dart';
import '../../reusable_widgets/snack_bars.dart';

class TestHomePage extends StatefulWidget {

   TestHomePage({Key? key}) : super(key: key);

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  final CalendarController calendarController =  Get.put(CalendarController());
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>SafeArea(
        child: Column(
          children: [
            Expanded(child:controller.appController.loading.value ? Center(
              child: SendingLoadingWidget(),
            ) : SingleChildScrollView(
              child: Column(
                children: controller.appController.listOfErrors.value.map((e) => Text(e)).toList(),
              ),
            )),
            InkWell(
              onTap: () async {
                controller.appController.loading.value = true;
                controller.appController.listOfErrors.add('entering attendance button');
                try{
                  LocationPermission permission =
                      await controller.appController.determinePosition();
                  controller.appController.listOfErrors.add('permission == LocationPermission.whileInUse');
                }on LocationDeniedException{
                  controller.appController.listOfErrors.add('again: LocationDeniedException');
                } catch (e) {
                  controller.appController.listOfErrors.add('exception: ${e.toString()}');
                }
                var respo = await controller.registerAttendance();
                controller.appController.listOfErrors.add(respo);
                controller.appController.loading.value = false;
              },
              child: Container(
                width: double.infinity,
                color: Colors.lightBlue,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text('reg_attend'.tr),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
     
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } 
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    
    controller.appController.listOfErrors.add('version.release: ${build.version.release},');
    controller.appController.listOfErrors.add('brand: ${build.brand},');
    controller.appController.listOfErrors.add('brand: ${build.model},');
    controller.appController.listOfErrors.add('version.baseOS: ${build.version.baseOS},');

    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,

      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
      ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }
}
