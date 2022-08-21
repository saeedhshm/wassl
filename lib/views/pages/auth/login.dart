import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/profile/info.dart';
import 'package:wassl/views/pages/profile/user_profile.dart';
import 'package:wassl/views/reusable_widgets/custom_checkbox.dart';
import 'package:wassl/views/reusable_widgets/main_button.dart';
import '../../../helpers/constants/sring_constans.dart';
import '../../reusable_widgets/custom_text_form_field.dart';
import '../../reusable_widgets/localized_text.dart';
import '../../reusable_widgets/main_title_text.dart';
import '../../reusable_widgets/svg_widget.dart';
import '../main_tabs_page.dart';
import 'login_widgets.dart';

class LoginPage extends StatefulWidget {


   LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool startAnim = true;
  bool showRestItems = false;

  late Animation<Offset> emailOffset = Tween<Offset>(begin: Offset( 0.0, (Get.size.height / 3.75)), end: Offset.zero)
      .animate(emailController);
  late AnimationController emailController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );

  double _width = 250, _height = 250;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() {
      setState(() {});
    });
    Future.delayed(Duration(milliseconds: 500),(){
      setState((){
        startAnim = false;
        _height = 50;
        _width = 130;
        emailController.forward();
      });
      Future.delayed(Duration(milliseconds: 1500),(){
        setState(()=>showRestItems = true);
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: double.infinity,
        color: AppColors.mainBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:  60,),
              Transform.translate(
                offset: emailOffset.value,
                child: Hero(
                  tag: logoAppHeroTag,
                  child: AnimatedContainer(
                      // color: Colors.blue,
                      width: _width,
                      height: _height,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: SvgWidget("assets/images/wasl.svg")),
                ),
              ),
              RestWidgets()

            ],
          ),
        ),
      ),
    );
  }
}
