import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/settings/pages/change_lang.dart';
import 'package:wassl/views/pages/settings/pages/change_password.dart';
import 'package:wassl/views/pages/settings/pages/notifs_page.dart';

import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/list_profile_item_widget.dart';
import '../../reusable_widgets/main_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                InkWell(
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
                  onTap: (){
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
                InkWell(
                  onTap: (){
                    Get.to(()=>ChangeLangPage());
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
                ListProfileItemWidget(
                  title: "logout".tr,
                  spaceInBetween: 16,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  iconSize: 35,
                  icon: "assets/images/settingicons/11.png",
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
