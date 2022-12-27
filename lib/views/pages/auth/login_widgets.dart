import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

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

  AppController appController = Get.find<AppController>();

  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

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

    userNameCtrl.text = 'test@wasl.com';
    passwordCtrl.text = '123456';

    emailController.addListener(() {
      setState(() {});
    });
    Future.delayed(const Duration(milliseconds: 1500),(){
      emailController.forward();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: emailOffset.value,
      child: Column(
        children: [
          const SizedBox(height: 30,),
          LocalizedText(
            "welcome_to_wasl",
            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black,),
          ),
          LocalizedText(
            "you_can_enter_to_account",
            textStyle: const TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          const SizedBox(height: 50,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width:double.infinity,child: MainTitleText("email_or_job_number")),
              const SizedBox(height: 0,),
              CustomTextFormField(
                hintText: 'email_address@email.com',
                labelText: null,
                controller: userNameCtrl,
              ),
              const SizedBox(height: 20,),
              SizedBox(width:double.infinity,child: MainTitleText("password")),
              const SizedBox(height: 0,),
              CustomTextFormField(
                hintText: '⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆',
                labelText: null,
                secureText: true,
                controller: passwordCtrl,
                suffixIcon: const Icon(Icons.visibility_off_outlined,color: AppColors.lightGreyTextColor,),
              ),
              const SizedBox(height: 5,),
              CustomCheckbox(title: 'remember_me', onChanged: (bool value){})
            ],
          ),
          const SizedBox(height: 120,),
          MainButtonWidget(btnTitle: 'login', onPressed: () async {
            println('botton login pressed');
           await appController.login(email: userNameCtrl.text,password: passwordCtrl.text);
            // Get.to(()=>const MainTabsPage());
          }),
          const SizedBox(height: 10,),
          MainTitleText("forget_password?"),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
