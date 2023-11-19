import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../../getx_controllers/attendance/member_attendance_controller.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../models/attendance/member_attendace_v2.dart';
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
                    const SizedBox(height: 40,),
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
                              const SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Center(
                                      child: Text('members'.tr,style: const TextStyle(
                                        color: AppColors.darkGreyTextColor,
                                          fontWeight: FontWeight.bold
                                        // fontSize: 12
                                      ),),
                                    )),
                                    Expanded(child: Row(
                                      children: [
                                        Expanded(child: Center(
                                          child: Text('attend'.tr,style: const TextStyle(
                                              color: AppColors.darkGreyTextColor,
                                              fontWeight: FontWeight.bold
                                            // fontSize: 12
                                          ),),
                                        ),),
                                        Expanded(child: Center(
                                          child: Text('leaving'.tr,style: const TextStyle(
                                              color: AppColors.darkGreyTextColor,
                                              fontWeight: FontWeight.bold
                                            // fontSize: 12
                                          ),),
                                        ),),
                                      ],
                                    ))
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
                                        memberAttendance: controller.teamAttendance[index],
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
                                    itemCount: controller.teamAttendance.length)),
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

  final MemberAttendance memberAttendance;
  const MemberItemWidget({
    Key? key,
    required this.memberAttendance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8),
      child: Row(
        children: [

          Expanded(

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
                const SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(memberAttendance.fullName,style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                    ),),

                    Text(memberAttendance.jobName,style: const TextStyle(
                        color: AppColors.lightGreyTextColor,
                        fontSize: 12
                    ),),
                  ],
                ),
              ],
            ),

          ),
          Expanded(

              child:  Column(
            children: memberAttendance.attendance.map((e) => e.isExempt ? Center(
    child: Text('exempt'.tr,style: const TextStyle(
    color: AppColors.darkGreyTextColor,
    fontWeight: FontWeight.bold
    // fontSize: 12
    ),),
    ) : e.attendanceTime.contains('--') ? Center(
              child: Text(e.attendanceStatus.tr,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontWeight: FontWeight.bold
                // fontSize: 12
              ),),
            ) :
            Row(
              children: [
                Expanded(

                  child: Center(
                    child: Text(e.attendanceTime,style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.bold
                      // fontSize: 12
                    ),),
                  ),
                ),
                Expanded(

                  child: Center(
                    child: Text(e.leaveTime,style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.bold
                      // fontSize: 12
                    ),),
                  ),
                ),
              ],
            ),).toList(),
          ))
        ],
      ),
    );
  }
}
