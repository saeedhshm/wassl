import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import '../../../helpers/constants/print_ln.dart';
import '../../../web_services_helper/urls.dart';
import '../../reusable_widgets/svg_widget.dart';
import 'login_widgets.dart';

class TestLoginPage extends StatefulWidget {


  TestLoginPage({Key? key}) : super(key: key){
    AppUrls.appDomain =  'https://waslhr-test.com';
    println(AppUrls.appDomain);
  }

  @override
  State<TestLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<TestLoginPage>  {
  bool startAnim = true;
  bool showRestItems = false;

  // late Animation<Offset> emailOffset = Tween<Offset>(begin: Offset( 0.0, (Get.size.height / 3.75)), end: Offset.zero)
  //     .animate(emailController);
  // late AnimationController emailController = AnimationController(
  //   duration: const Duration(milliseconds: 400),
  //   vsync: this,
  // );

  double _width = 130, _height = 50;
  // double _width = 250, _height = 250;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // emailController.addListener(() {
    //   setState(() {});
    // });
    // Future.delayed(Duration(milliseconds: 500),(){
    //   setState((){
    //     startAnim = false;
    //     _height = 50;
    //     _width = 130;
    //     emailController.forward();
    //   });
    //   Future.delayed(Duration(milliseconds: 1500),(){
    //     setState(()=>showRestItems = true);
    //   });
    // });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: double.infinity,
        color: AppColors.mainBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height:  60,),
              // Transform.translate(
                // offset: emailOffset.value,
                Hero(
                  tag: 'logoAppHeroTag',
                  child: AnimatedContainer(
                      // color: Colors.blue,
                      width: _width,
                      height: _height,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: const SvgWidget("assets/images/wasl.svg")),
                ),
              // ),
              const RestWidgets(),

              SafeArea(child: GestureDetector(
                onTap: (){
                  AppUrls.appDomain = 'https://waslhr.com';
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('back_to_live'.tr,style: const TextStyle(
                    color: AppColors.redMissedDayColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
