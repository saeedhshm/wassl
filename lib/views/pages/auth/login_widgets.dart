import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../reusable_widgets/custom_checkbox.dart';
import '../../reusable_widgets/custom_text_form_field.dart';
import '../../reusable_widgets/localized_text.dart';
import '../../reusable_widgets/main_button.dart';
import '../../reusable_widgets/main_title_text.dart';
import '../main_tabs_page.dart';

class RestWidgets extends StatefulWidget {
  const RestWidgets({Key? key}) : super(key: key);

  @override
  State<RestWidgets> createState() => _RestWidgetsState();
}

class _RestWidgetsState extends State<RestWidgets> with TickerProviderStateMixin {

  late Animation<Offset> emailOffset = Tween<Offset>(begin: Offset( 0.0, Get.size.height), end: Offset.zero)
      .animate(emailController);
  late AnimationController emailController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailController.addListener(() {
      setState(() {});
    });
    Future.delayed(Duration(milliseconds: 1500),(){
      emailController.forward();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: emailOffset.value,
      child: Container(

        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(

              child: LocalizedText(
                "welcome_to_wasl",
                textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black,),
              ),
            ),
            Container(
              child: LocalizedText(
                "you_can_enter_to_account",
                textStyle: TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            SizedBox(height: 50,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width:double.infinity,child: MainTitleText("email_or_job_number")),
                SizedBox(height: 0,),
                CustomTextFormField(
                  hintText: 'email_address@email.com',
                  labelText: null,
                ),
                SizedBox(height: 20,),
                SizedBox(width:double.infinity,child: MainTitleText("password")),
                SizedBox(height: 0,),
                CustomTextFormField(
                  hintText: '⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆',
                  labelText: null,
                  secureText: true,
                  suffixIcon: Icon(Icons.visibility_off_outlined,color: AppColors.lightGreyTextColor,),
                ),
                SizedBox(height: 5,),
                CustomCheckbox(title: 'remember_me', onChanged: (bool value){})
              ],
            ),
            SizedBox(height: 120,),
            MainButtonWidget(btnTitle: 'login', onPressed: (){
              Get.to(()=>const MainTabsPage());
            }),
            SizedBox(height: 10,),
            MainTitleText("forget_password?"),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
