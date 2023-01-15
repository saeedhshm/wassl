import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/home/home_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/reusable_widgets/snack_bars.dart';

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
                Text('welcome'.tr +' : ' + controller.appController.loginModel.value.user!.fullName!,style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                const Spacer(),
                SizedBox(height: 55,width:55,child: Image.asset('assets/images/settingicons/12.png',color: Colors.white,)),
              ],
            ),
          ),
          Container(color: Colors.white,width: double.maxFinite,height: 0.5,),
          const SizedBox(height: 20,),
          Text('egypt'.tr,style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          const SizedBox(height: 10,),
          Text('working_period'.tr,style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          const SizedBox(height: 10,),
          Text('8:00 ${'am'.tr} - 3:00 ${'pm'.tr}',style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          const SizedBox(height: 20,),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
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
                                const SizedBox(height: 20,),
                                Row(
                                  children: [
                                    const Spacer(),
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
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: SvgWidget('assets/images/holidays.svg'),
                                          ),
                                          decoration: BoxDecoration(
                                              color: AppColors.mainBackgroundColor,
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text('holidays'.tr,
                                          style: const TextStyle(
                                              color: AppColors.darkGreyTextColor
                                          ),)
                                      ],
                                    ),
                                    const Spacer(),
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
                                    const Spacer(),
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
                  decoration: const BoxDecoration(
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
                      margin:const EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(()=>IgnorePointer(
                        ignoring: controller.attendanceStatus.value == 3 || controller.sendingAttendance.value,
                        // ignoring: false,
                        child: InkWell(
                          onTap: () async{

                            var attendanceDone = await controller.registerAttendance();
                            if(attendanceDone){
                              var message = '';
                              if(controller.attendanceStatus.value == 2){
                                message = 'attendance_done_successfully'.tr;
                              }else {
                                message = 'leaving_done_successfully'.tr;
                              }
                              SnackBars.showConfirmedSnackBar('', message);
                            }else{
                              SnackBars.showErrorSnackBar('error', 'something_wrong_try_again'.tr);
                            }

                          },
                          child: controller.sendingAttendance.value ? const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: SendingLoadingWidget(),
                          ) :  Row(
                            children: [
                              const SizedBox(width: 16,),
                              Container(

                                child: CircularWidget(size: 50,borderWidth: 0,padding: 0,borderColor: Colors.transparent,
                                    child: Image.asset('assets/images/profile/1.png')),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 1),
                                      blurRadius: 1,
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.attendanceStatusValue,style: const TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  // SizedBox(height: 10,),
                                  Text(controller.currentTime,style: const TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                                child: SizedBox(
                                  width: 50,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
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
                            offset: const Offset(0, 1),
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
