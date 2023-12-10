import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/intro/splash_screen.dart';

import 'helpers/translation/local_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppController appController = Get.put(AppController());

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  tz.initializeTimeZones();

  await appController.getLanguage();

  await initializeDateFormatting();

  appController.deployingForApple = true;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  AppController appController = Get.find();

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
