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


  final CalendarController calendarController =  Get.put(CalendarController());
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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




}
