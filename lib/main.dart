import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:wassl/firbase_handler/firbase_api.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/test_page.dart';
import 'package:wassl/views/pages/intro/splash_screen.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/intro/test_home_page.dart';
import 'helpers/constants/print_ln.dart';
import 'helpers/translation/local_strings.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  tz.initializeTimeZones();
  AppController appController = Get.put(AppController());

  await initializeDateFormatting();
  await FirebaseApi().initNotifications();

  appController.deployingForApple = true;
  runApp( MyApp());
}




class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key){
     // _readAndroidBuildData().then((value) {
     //   value.forEach((key, value) {
     //     println('--->>$key --->> $value');
     //   });
     // });
   }

  // This widget is the root of your application.

   AppController appController = Get.find();
   static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
   Map<String, dynamic> _deviceData = <String, dynamic>{};



  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Wasl',
      translations: LocalString(),
      locale:  Locale(appController.langs[0],appController.langs[1]),
      localizationsDelegates: const [

        // GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'AraHamah',
      ),
      home:   SplashScreen(),
      // home:TestCodesPage()
    );
  }


}
