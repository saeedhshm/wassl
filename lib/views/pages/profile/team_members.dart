import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../../getx_controllers/attendance/member_attendance_controller.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../models/attendance/member_attendace.dart';
import '../../reusable_widgets/main_appbar.dart';

class TeamMembersPage extends StatelessWidget {


  final controller = Get.find<MembersAttendanceController>();

   TeamMembersPage({Key? key}) : super(key: key){
     controller.getTeamAttendance();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            "team_member",
            onBack: () {
              Get.back();
            },
          ),
          const SizedBox(height: 40,),
          Expanded(
            child: Stack(
              children: [

                Column(
                  children: [
                    SizedBox(height: 40,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 50,),
                              Text('${controller.appController.loginModel.value.user?.fullName}',style: const TextStyle(
                                color: AppColors.darkGreyTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                              ),),
                              Text('team_chief'.tr,style: const TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  // fontSize: 12
                              ),),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Text('members'.tr,style: const TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                        fontWeight: FontWeight.bold
                                      // fontSize: 12
                                    ),),flex: 7,),
                                    Expanded(flex: 3,child: Text('attend'.tr,style: const TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                        fontWeight: FontWeight.bold
                                      // fontSize: 12
                                    ),),),
                                    Expanded(flex: 3,child: Text('leaving'.tr,style: const TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                        fontWeight: FontWeight.bold
                                      // fontSize: 12
                                    ),),),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 20,),
                              Expanded(
                                child: Obx(()=>controller.loading.value ?
                                const Center(
                                  child: SendingLoadingWidget(),
                                )
                                    :ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (_,index){
                                      return MemberItemWidget(
                                        member: controller.teamAttendance.value.teamAttendance[index],
                                      );
                                    },
                                    separatorBuilder: (_,index){
                                      return Container(
                                        width: double.infinity,
                                        height: 1,
                                        decoration: const BoxDecoration(
                                            color: AppColors.mainBackgroundColor
                                        ),
                                      );
                                    },
                                    itemCount: controller.teamAttendance.value.teamAttendance.length)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width:80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0,0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Image.asset('assets/images/profile/1.png')),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MemberItemWidget extends StatelessWidget {

  final MemberAttendance member;
  const MemberItemWidget({
    Key? key,
    required this.member,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8),
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0,0), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset('assets/images/profile/1.png',width: 40,)),
          const SizedBox(width: 16,),
          Expanded(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.fullName,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 13
                ),),

                // Text('مطور واجهات'.tr,style: TextStyle(
                //     color: AppColors.lightGreyTextColor,
                //     fontSize: 12
                // ),),
              ],
            ),
            flex: 5,
          ),
          Expanded(
            flex: 3,
            child: Text(member.attendanceTime,style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontWeight: FontWeight.bold
                // fontSize: 12
            ),),
          ),
          Expanded(
            flex: 3,
            child: Text(member.leaveTime,style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontWeight: FontWeight.bold
                // fontSize: 12
            ),),
          ),
        ],
      ),
    );
  }
}
