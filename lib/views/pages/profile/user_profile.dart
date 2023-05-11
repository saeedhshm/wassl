import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/profile/info.dart';
import 'package:wassl/views/reusable_widgets/light_text_widget.dart';
import '../../../getx_controllers/app_controller.dart';
import '../../reusable_widgets/circular_widget.dart';
import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/list_profile_item_widget.dart';
import '../settings/settings_page.dart';

class UserProfilePage extends StatelessWidget {

   UserProfilePage({Key? key}) : super(key: key);
   final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(
              top: height*1.5,
              left: 16,
              right: 16
            ),
            child: Column(
              children: [
                // SizedBox(height: ,),
                Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularWidget(
                          size: 100,
                          child: Image.asset('assets/images/profile/1.png'),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      child: InkWell(
                        onTap: (){
                          Get.to(()=>SettingsPage());
                        },
                        child: SizedBox(
                            width: 45,
                            child: Image.asset('assets/images/profile/setting.png')),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                DarkTextWidget(appController.loginModel.value.user?.fullName ?? '',fontSize: 20,),
                const SizedBox(height: 0,),
                DarkTextWidget(appController.loginModel.value.user?.job?.name ?? '',fontSize: 15,),
                const SizedBox(height: 20,),
                appController.deployingForApple ? const SizedBox() :  const SizedBox(width:double.infinity,child: LightTextWidget('anual_vacations',fontSize: 15
                  ,)),
                appController.deployingForApple ? const SizedBox() :  const SizedBox(height: 10,),
                appController.deployingForApple ? const SizedBox() : ListProfileItemWidget(
                  title: "رصيد الاجازات ٥ ايام متاحة الاستخدام",
                  icon: "assets/images/profile/vacation.png",
                ),
                const SizedBox(height: 20,),
                const SizedBox(width:double.infinity,child: LightTextWidget('profile',fontSize: 15,)),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    Get.to(()=>InfoPage());
                  },
                  child: ListProfileItemWidget(
                    title: "profile_info",
                    icon: "assets/images/profile/1.png",
                  ),
                ),
                appController.deployingForApple ? const SizedBox() :  ListProfileItemWidget(
                  title: "work_info",
                  icon: "assets/images/profile/2.png",
                ),
                appController.deployingForApple ? const SizedBox() :  ListProfileItemWidget(
                  title: "money_info",
                  icon: "assets/images/profile/3.png",
                ),
                appController.deployingForApple ? const SizedBox() :  ListProfileItemWidget(
                  title: "docs",
                  icon: "assets/images/profile/4.png",
                ),
                appController.deployingForApple ? const SizedBox() :   ListProfileItemWidget(
                  title: "contracts",
                  icon: "assets/images/profile/5.png",
                ),
                appController.deployingForApple ? const SizedBox() :  ListProfileItemWidget(
                  title: "Custodys",
                  icon: "assets/images/profile/6.png",
                ),


                const SizedBox(height: 110,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
