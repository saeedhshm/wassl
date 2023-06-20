import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/profile/info.dart';
import 'package:wassl/views/pages/profile/team_members.dart';
import 'package:wassl/views/pages/profile/widgets/header_widget.dart';
import 'package:wassl/views/reusable_widgets/light_text_widget.dart';
import '../../../getx_controllers/app_controller.dart';
import '../../../getx_controllers/attendance/member_attendance_controller.dart';
import '../../reusable_widgets/circular_widget.dart';
import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/list_profile_item_widget.dart';
import '../covenant/page.dart';
import '../documents/page.dart';
import '../finance_info/finance.dart';
import '../holidays/holiday_details.dart';
import '../settings/settings_page.dart';

class UserProfilePage extends StatelessWidget {

   UserProfilePage({Key? key}) : super(key: key);
   final AppController appController = Get.find();
   final membersAttendanceController = Get.put(MembersAttendanceController());

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
                // image, name, job and settings
                HeaderWidget(),
                // vacations
                const SizedBox(width:double.infinity,child: LightTextWidget('anual_vacations',fontSize: 15
                  ,)),
                const SizedBox(height: 10,),

                // vacations information
                InkWell(
                  onTap: (){
                    Get.to(()=>HolidaysDetails());
                  },
                  child: ListProfileItemWidget(
                    title: "رصيد الاجازات ${(appController.holidaysBalance.value.data?.availableVacationsCount ?? 0).toInt()} ايام متاحة الاستخدام",
                    icon: "assets/images/profile/vacation.png",
                  ),
                ),

                const SizedBox(height: 20,),
                const SizedBox(width:double.infinity,child: LightTextWidget('profile',fontSize: 15,)),
                const SizedBox(height: 10,),

                // profile information
                InkWell(
                  onTap: (){
                    Get.to(()=>InfoPage());
                  },
                  child: ListProfileItemWidget(
                    title: "profile_info",
                    icon: "assets/images/profile/1.png",
                  ),
                ),
                // team members attendance
                membersAttendanceController.hasTeamMembers ? InkWell(
                  onTap: (){
                    Get.to(()=>TeamMembersPage());
                  },
                  child: ListProfileItemWidget(
                    title: "team_member",
                    icon: "assets/images/profile/team.png",
                  ),
                ) : SizedBox(),

                //working information
                appController.deployingForApple ? const SizedBox() :  ListProfileItemWidget(
                  title: "work_info",
                  icon: "assets/images/profile/2.png",
                ),

                //finance information
                InkWell(
                  onTap: (){
                    Get.to(()=>FinanceInfoPage());
                  },
                  child: ListProfileItemWidget(
                    title: "money_info",
                    icon: "assets/images/profile/3.png",
                  ),
                ),

                // documents information
                InkWell(
                  onTap: (){
                    Get.to(()=>DocsPage());
                  },
                  child: ListProfileItemWidget(
                    title: "docs",
                    icon: "assets/images/profile/4.png",
                  ),
                ),

                //contracts information
                appController.deployingForApple ? const SizedBox() :   ListProfileItemWidget(
                  title: "contracts",
                  icon: "assets/images/profile/5.png",
                ),

                //Covenant information
                InkWell(
                  onTap: (){
                    Get.to(()=>CovenantPage());
                  },
                  child: ListProfileItemWidget(
                    title: "Custodys",
                    icon: "assets/images/profile/6.png",
                  ),
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


