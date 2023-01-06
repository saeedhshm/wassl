import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_utils/get_utils.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/getx_controllers/home/home_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../reusable_widgets/circular_widget.dart';
import '../../reusable_widgets/svg_widget.dart';

class HomePage extends StatelessWidget {

   HomePage({Key? key}) : super(key: key);

   final HomeController controller = Get.put(HomeController());

  // String name = 'محمد حسين';

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 35,
              bottom: 20,
              left: 16,
              right: 16
            ),
            child: Row(
              children: [
                Text('welcome'.tr +' : ' + controller.appController.loginModel.value.user!.fullName!,style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                Spacer(),
                SizedBox(height: 55,width:55,child: Image.asset('assets/images/settingicons/12.png',color: Colors.white,)),
              ],
            ),
          ),
          Container(color: Colors.white,width: double.maxFinite,height: 0.5,),
          SizedBox(height: 20,),
          Text('egypt'.tr,style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10,),
          Text('working_period'.tr,style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10,),
          Text('8:00 ${'am'.tr} - 3:00 ${'pm'.tr}',style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 20,),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  width: double.infinity,
                  height: double.maxFinite,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    bottom: 20
                                  ),
                                  child: Row(
                                    children: [
                                      Text('requests'.tr,style: const TextStyle(
                                          color: AppColors.darkGreyTextColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      const Spacer(),
                                      Text('more'.tr,style: const TextStyle(
                                          color: AppColors.darkGreyTextColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: SvgWidget('assets/images/finger_print.svg'),
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.mainBackgroundColor,
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text('correct'.tr,
                                        style: TextStyle(
                                          color: AppColors.darkGreyTextColor
                                        ),)
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgWidget('assets/images/holidays.svg'),
                                          ),
                                          decoration: BoxDecoration(
                                              color: AppColors.mainBackgroundColor,
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text('holidays'.tr,
                                          style: TextStyle(
                                              color: AppColors.darkGreyTextColor
                                          ),)
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: SvgWidget('assets/images/finger_print.svg'),
                                          ),
                                          decoration: BoxDecoration(
                                              color: AppColors.mainBackgroundColor,
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text('correct'.tr,
                                          style: const TextStyle(
                                              color: AppColors.darkGreyTextColor
                                          ),)
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mainBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    )
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin:EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(()=>IgnorePointer(
                        ignoring: controller.sendingAttendance.value,
                        // ignoring: false,
                        child: InkWell(
                          onTap: () async{
                            if(controller.isAttended.value){
                              controller.registerLeaving();
                            }else {
                              controller.registerAttendance();
                            }

                          },
                          child: controller.sendingAttendance.value ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SendingLoadingWidget(),
                          ) :  Row(
                            children: [
                              SizedBox(width: 16,),
                              Container(

                                child: CircularWidget(size: 50,borderWidth: 0,padding: 0,borderColor: Colors.transparent,
                                    child: Image.asset('assets/images/profile/1.png')),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 1),
                                      blurRadius: 1,
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.isAttended.value ? 'reg_leaving'.tr : 'reg_attend'.tr,style: TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  // SizedBox(height: 10,),
                                  Text('${controller.hours}:${controller.minutes} ${controller.am_pm}',style: TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                                child: SizedBox(
                                  width: 50,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      child:Image.asset('assets/images/attend_print_ic.png')),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0, 1),
                            blurRadius: 5,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        gradient: greenGradiantAppBar,
      ),
    );
  }
}
