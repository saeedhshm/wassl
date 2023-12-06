import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../../getx_controllers/calendar/calendar_controller.dart';
import '../../../getx_controllers/home/home_controller.dart';
import '../../../helpers/exceptions/location_exceptions.dart';

class TestHomePage extends StatefulWidget {
  const TestHomePage({Key? key}) : super(key: key);

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  final CalendarViewModel calendarController = Get.put(CalendarViewModel());
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Expanded(
                      child: controller.appController.loading.value
                          ? const Center(
                              child: SendingLoadingWidget(),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: controller
                                    .appController.listOfErrors.value
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(e),
                                        ))
                                    .toList(),
                              ),
                            )),
                  InkWell(
                    onTap: () async {
                      controller.appController.loading.value = true;
                      controller.appController.listOfErrors
                          .add('entering attendance button');
                      try {
                        LocationPermission permission =
                            await controller.appController.determinePosition();
                        controller.appController.listOfErrors
                            .add('permission == LocationPermission.whileInUse');
                      } on LocationDeniedException {
                        controller.appController.listOfErrors
                            .add('again: LocationDeniedException');
                      } catch (e) {
                        controller.appController.listOfErrors
                            .add('exception: ${e.toString()}');
                      }
                      var bearer =
                          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3dhc2xoci5jb20vYXBpL3YxL2F1dGgvbG9naW4iLCJpYXQiOjE2ODY0NTkxMjIsImV4cCI6MTcyMjQ1OTEyMiwibmJmIjoxNjg2NDU5MTIyLCJqdGkiOiJuTkNiakNvRWVSaUIwc0hoIiwic3ViIjoiMjEiLCJwcnYiOiJjMDgzZmI4MjU5YWRmYWE1YTg0OTI1NjMzNTM3ZWU5Y2JiMGE4NmUxIn0.BZV_QvaqZup5gr8BRXtHU55pLrJ7zS8vNPN_4njJlBQ';
                      var respo =
                          await controller.registerAttendance(bearer: bearer);
                      controller.appController.listOfErrors.add(respo);
                      controller.appController.listOfErrors
                          .add(' حساب التجربة');
                      controller.appController.loading.value = false;
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.lightBlue,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text('reg_attend'.tr),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
