import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/views/pages/auth/login.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

import '../../../helpers/constants/sring_constans.dart';
import '../main_tabs_page.dart';

class SplashScreen extends StatefulWidget {



   SplashScreen({Key? key}) : super(key: key){

  }

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

  onStartScreen() async{
    var userCreds = await appController.retrieveUserAuth();
    var email = userCreds['email'] ?? '';
    var password = userCreds['password'] ?? '';
   var response = await appController.login(email: email, password: password);

    timer = Timer(Duration(seconds: 3),
            (){
              if(response){
                Get.to(()=>const MainTabsPage());
              }else {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        LoginPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              }
            }
    );
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
        child: Center(
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
