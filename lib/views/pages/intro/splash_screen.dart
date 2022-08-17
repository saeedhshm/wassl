import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wassl/views/pages/auth/login.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

import '../../../helpers/constants/sring_constans.dart';

class SplashScreen extends StatefulWidget {



   SplashScreen({Key? key}) : super(key: key){

  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => LoginPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            )
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
