import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/profile/info.dart';
import 'package:wassl/views/reusable_widgets/custom_checkbox.dart';
import 'package:wassl/views/reusable_widgets/main_button.dart';
import '../../../helpers/constants/sring_constans.dart';
import '../../reusable_widgets/custom_text_form_field.dart';
import '../../reusable_widgets/localized_text.dart';
import '../../reusable_widgets/main_title_text.dart';
import '../../reusable_widgets/svg_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
              SizedBox(height: 50,),
              Hero(
                tag: logoAppHeroTag,
                child: Container(
                    // color: Colors.blue,
                    width: 150,
                    height: 100,
                    child: SvgWidget("assets/images/wasl.svg")),
              ),
              Container(
                child: LocalizedText(
                  "welcome_to_wasl",
                  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: LocalizedText(
                  "you_can_enter_to_account",
                  textStyle: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
              SizedBox(height: 70,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width:double.infinity,child: MainTitleText("email_or_job_number")),
                  SizedBox(height: 10,),
                  CustomTextFormField(
                    hintText: 'email_address@email.com',
                    labelText: null,
                  ),
                  SizedBox(height: 20,),
                  SizedBox(width:double.infinity,child: MainTitleText("password")),
                  SizedBox(height: 10,),
                  CustomTextFormField(
                    hintText: '*********',
                    labelText: null,
                    secureText: true,
                    icon: Icon(Icons.visibility_off_outlined,color: AppColors.mainDeepGreyColor,),
                  ),
                  SizedBox(height: 10,),
                  CustomCheckbox(title: 'remember_me', onChanged: (bool value){})
                ],
              ),
              SizedBox(height: 70,),
              MainButtonWidget(btnTitle: 'login', onPressed: (){
                Get.to(InfoPage());
              }),
              SizedBox(height: 20,),
              MainTitleText("forget_password?"),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
