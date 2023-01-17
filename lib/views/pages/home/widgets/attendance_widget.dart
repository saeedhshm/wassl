import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/circular_widget.dart';
import '../../../reusable_widgets/snack_bars.dart';

class AttendanceWidget extends StatelessWidget {

  final HomeController controller = Get.find();
   AttendanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(()=>IgnorePointer(
            ignoring: controller.attendanceStatus.value == 3 || controller.sendingAttendance.value,
            // ignoring: false,
            child: InkWell(
              onTap: () async{

                Get.defaultDialog(
                  title: controller.attendanceStatus.value == 1 ? 'reg_attend'.tr : 'reg_leaving'.tr,
                  middleText: controller.attendanceStatus.value == 1 ? 'sure_to_attend?'.tr : 'sure_to_leave?'.tr,
                  cancel: InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color:Colors.red,
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 30),
                          child: Text('cancel'.tr,style: const TextStyle(
                            color: Colors.white
                          ),),
                        )),
                  ),
                  confirm: InkWell(
                    onTap: ()async{
                      Get.back();
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
                    child: Container(

                        decoration: BoxDecoration(
                            color:AppColors.mainGreenColor,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 30),
                          child: Text(controller.attendanceStatus.value == 1 ? 'attendance'.tr : 'leaving'.tr,style: const TextStyle(
                              color: Colors.white
                          ),),
                        )),
                  ),

                );



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
    );
  }
}
