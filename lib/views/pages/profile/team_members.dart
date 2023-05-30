import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../reusable_widgets/main_appbar.dart';

class TeamMembersPage extends StatelessWidget {
  const TeamMembersPage({Key? key}) : super(key: key);

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
          SizedBox(height: 40,),
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
                              SizedBox(height: 50,),
                              Text('أحمد محمد',style: TextStyle(
                                color: AppColors.darkGreyTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                              ),),
                              Text('team_chief'.tr,style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  // fontSize: 12
                              ),),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Text('members'.tr,style: TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                        fontWeight: FontWeight.bold
                                      // fontSize: 12
                                    ),),flex: 2,),
                                    Expanded(child: Text('attend'.tr,style: TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                        fontWeight: FontWeight.bold
                                      // fontSize: 12
                                    ),),),
                                    Expanded(child: Text('leaving'.tr,style: TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                        fontWeight: FontWeight.bold
                                      // fontSize: 12
                                    ),),),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 20,),
                              Expanded(
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                    itemBuilder: (_,index){
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
                                                      offset: Offset(0,0), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Image.asset('assets/images/profile/1.png',width: 40,)),
                                            SizedBox(width: 16,),
                                            Expanded(

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('أحمد محمد',style: TextStyle(
                                                    color: AppColors.darkGreyTextColor,
                                                    fontWeight: FontWeight.bold
                                                  ),),

                                                  Text('مطور واجهات'.tr,style: TextStyle(
                                                      color: AppColors.lightGreyTextColor,
                                                      fontSize: 12
                                                  ),),
                                                ],
                                              ),
                                              flex: 4,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text('10:30 ${'am'.tr}',style: TextStyle(
                                                  color: AppColors.darkGreyTextColor,
                                                  fontWeight: FontWeight.bold
                                                  // fontSize: 12
                                              ),),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text('10:30 ${'am'.tr}',style: TextStyle(
                                                  color: AppColors.darkGreyTextColor,
                                                  fontWeight: FontWeight.bold
                                                  // fontSize: 12
                                              ),),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_,index){
                                      return Container(
                                        width: double.infinity,
                                        height: 1,
                                        decoration: BoxDecoration(
                                            color: AppColors.mainBackgroundColor
                                        ),
                                      );
                                    },
                                    itemCount: 10),
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
                              offset: Offset(0,0), // changes position of shadow
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
