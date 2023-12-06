import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:wassl/firbase_handler/firbase_api.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/intro/splash_screen.dart';

import 'helpers/translation/local_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppController appController = Get.put(AppController());
  try {
    await Firebase.initializeApp();
    await FirebaseApi().initNotifications();
  } catch (e) {}

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  tz.initializeTimeZones();

  await appController.getLanguage();

  await initializeDateFormatting();

  appController.deployingForApple = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    // _readAndroidBuildData().then((value) {
    //   value.forEach((key, value) {
    //     println('--->>$key --->> $value');
    //   });
    // });
  }

  // This widget is the root of your application.

  AppController appController = Get.find();

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    // appController.testingUserName = 'mr.hussein.1416@gmail.com';
    appController.testingUserName = 'saeedhshm@gmail.com';
    appController.testingUserName = 'test2@waslhr.com';
    // appController.testingUserName = 'ceo@trafficksa.com'; //1234567 salem
    // appController.testingUserName = 'info@trafficksa.com'; //1234567 kholoud
    // appController.testingUserName = 'nawal@trafficksa.com'; //1234567 kholoud

    return GetMaterialApp(
        title: 'Wasl',
        translations: LocalString(),
        locale: Locale(appController.langs[0], appController.langs[1]),
        localizationsDelegates: const [
          // GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.materialOrangeColor,
          fontFamily: 'AraHamah',
        ),
        home: const SplashScreen()
        // home:TestCodesPage()
        );
  }
}
