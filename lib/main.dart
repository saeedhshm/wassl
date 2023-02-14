import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/views/pages/intro/splash_screen.dart';
import 'package:get/get.dart';
import 'getx_controllers/calendar/calendar_controller.dart';
import 'helpers/translation/local_strings.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  AppController appController = Get.put(AppController());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

   AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: LocalString(),
      locale: Locale("ar",""),
      debugShowCheckedModeBanner: !appController.deployingForApple,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        fontFamily: 'AraHamah',
      ),
      home:  Obx(()=>IgnorePointer(
        ignoring: appController.loading.value,
        child: const SplashScreen(),
      )),
    );
  }
}
