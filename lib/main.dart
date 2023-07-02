import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/views/pages/intro/splash_screen.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/intro/test_home_page.dart';
import 'helpers/constants/print_ln.dart';
import 'helpers/translation/local_strings.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  tz.initializeTimeZones();
  AppController appController = Get.put(AppController());
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
      locale: const Locale("ar",""),
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
      // home:TestHomePage()
    );
  }

   // Future<Map<String, dynamic>> _readAndroidBuildData() async {
   //
   //   var build = await deviceInfoPlugin.androidInfo;
   //
   //   return <String, dynamic>{
   //     'version.securityPatch': build.version.securityPatch,
   //     'version.sdkInt': build.version.sdkInt,
   //     'version.release': build.version.release,
   //     'version.previewSdkInt': build.version.previewSdkInt,
   //     'version.incremental': build.version.incremental,
   //     'version.codename': build.version.codename,
   //     'version.baseOS': build.version.baseOS,
   //     'board': build.board,
   //     'bootloader': build.bootloader,
   //     'brand': build.brand,
   //     'device': build.device,
   //     'display': build.display,
   //     'fingerprint': build.fingerprint,
   //     'hardware': build.hardware,
   //     'host': build.host,
   //     'id': build.id,
   //     'manufacturer': build.manufacturer,
   //     'model': build.model,
   //     'product': build.product,
   //     'supported32BitAbis': build.supported32BitAbis,
   //     'supported64BitAbis': build.supported64BitAbis,
   //     'supportedAbis': build.supportedAbis,
   //     'tags': build.tags,
   //     'type': build.type,
   //     'isPhysicalDevice': build.isPhysicalDevice,
   //     'systemFeatures': build.systemFeatures,
   //     'displaySizeInches':
   //     ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
   //     'displayWidthPixels': build.displayMetrics.widthPx,
   //     'displayWidthInches': build.displayMetrics.widthInches,
   //     'displayHeightPixels': build.displayMetrics.heightPx,
   //     'displayHeightInches': build.displayMetrics.heightInches,
   //     'displayXDpi': build.displayMetrics.xDpi,
   //     'displayYDpi': build.displayMetrics.yDpi,
   //     'serialNumber': build.serialNumber,
   //   };
   // }
}
