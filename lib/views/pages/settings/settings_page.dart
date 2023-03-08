import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/views/pages/settings/pages/change_lang.dart';
import 'package:wassl/views/pages/settings/pages/change_password.dart';
import 'package:wassl/views/pages/settings/pages/notifs_page.dart';

import '../../consts_widgets/loading_widgets.dart';
import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/list_profile_item_widget.dart';
import '../../reusable_widgets/main_appbar.dart';
import '../auth/login.dart';
import '../intro/splash_screen.dart';

class SettingsPage extends StatelessWidget {

   SettingsPage({Key? key}) : super(key: key);

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          body: Column(

            children: [
              MainAppbarWidget(
                'profile'.tr,
                onBack: () {
                  Get.back();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DarkTextWidget('settings'.tr,fontSize: 18,fontWeight: FontWeight.bold,),
                    SizedBox(height: 8,),
                    appController.deployingForApple ? const SizedBox() : InkWell(
                      onTap: (){
                        Get.to(()=>NotifsPage());
                      },
                      child: ListProfileItemWidget(
                        title: "notifs".tr,
                        spaceInBetween: 16,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        iconSize: 35,
                        icon: "assets/images/settingicons/12.png",
                      ),
                    ),
                    InkWell(
                      onTap: () async{

                        Get.to(()=>ChangePasswordPage());
                      },
                      child: ListProfileItemWidget(
                        title: "change_password".tr,
                        spaceInBetween: 16,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        iconSize: 35,
                        icon: "assets/images/settingicons/13.png",
                      ),
                    ),
                    appController.deployingForApple ? const SizedBox() :  InkWell(
                      onTap: (){
                        Get.to(()=>const ChangeLangPage());
                      },
                      child: ListProfileItemWidget(
                        title: "change_lang".tr,
                        spaceInBetween: 16,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        iconSize: 35,
                        icon: "assets/images/settingicons/14.png",
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await appController.logout();
                        Get.to(()=>LoginPage());
                      },
                      child: ListProfileItemWidget(
                        title: "logout".tr,
                        spaceInBetween: 16,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        iconSize: 35,
                        icon: "assets/images/settingicons/11.png",
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        appController.loading.value
            ? Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: SendingLoadingWidget(),
            ))
            : const SizedBox(),
      ],
    ));
  }
}
