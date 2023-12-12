import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/views/pages/auth/login.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

import '../../../helpers/constants/string_constants.dart';
import '../../../helpers/device_info/device_info_checker.dart';
import '../../../helpers/exceptions/internet_api_exceptions.dart';
import '../../../helpers/notifications/firbase_handler/firbase_api.dart';
import '../../../helpers/notifications/hms_notif.dart';
import '../main_tabs_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  AppController appController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onStartScreen();
  }

  onStartScreen() async {
    var deviceInfo = await DeviceInfoChecker().initPlatformState();

    if (deviceInfo.isHuaweiPhone) {
      var token = await HMSService().init();
    } else {
      try {
        await Firebase.initializeApp();
        await FirebaseApi().initNotifications();
      } catch (e) {}
    }
    var userCreds = await appController.retrieveUserAuth();
    var email = userCreds['email'] ?? '';
    var password = userCreds['password'] ?? '';
    timer = Timer(const Duration(seconds: 3), () async {
      try {
        await appController.login(email: email, password: password);

        Get.offAll(() => const MainTabsPage(), duration: Duration.zero);
      } on NoInternetException catch (e) {
        Get.defaultDialog(
            title: 'error'.tr,
            middleText: e.errorMessage,
            barrierDismissible: false);
      } on UserNotFoundException {
        Get.offAll(() => const LoginPage(), duration: Duration.zero);
      } catch (e) {
        Get.offAll(() => const LoginPage(), duration: Duration.zero);
      }
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: SizedBox(
            width: 250,
            child: Hero(
              tag: logoAppHeroTag,
              child: SvgWidget("assets/images/wasl.svg"),
            ),
          ),
        ),
      ),
    );
  }
}
