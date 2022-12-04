import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/notif_model.dart';
import 'package:wassl/views/reusable_widgets/load_image.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

import '../../../../getx_controllers/settings/notifs_controllers.dart';
import '../../../consts/gradiants.dart';
import '../../../reusable_widgets/main_appbar.dart';

class NotifsPage extends StatelessWidget {

   NotifsPage({Key? key}) : super(key: key);

  final controller = NotifsController.createInstance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            'notifs'.tr,
            onBack: () {
              NotifsController.deleteInstance();
              Get.back();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children:  [
                Obx(() => Container(
                  child:Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            controller.isWorkNotifs.value = true;
                          },
                          child: Container(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 20),
                            child: Text('work'.tr,style: TextStyle(
                                color: !controller.isWorkNotifs.value ? Colors.white : AppColors.darkGreyTextColor
                            ),),
                          ),decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: controller.isWorkNotifs.value ? Colors.white : Colors.transparent
                          ),),
                        ),
                        InkWell(
                          onTap: (){
                            controller.isWorkNotifs.value = false;
                          },
                          child: Container(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:5.0,horizontal: 20),
                            child: Text('occasions'.tr,style: TextStyle(
                                color: controller.isWorkNotifs.value ? Colors.white : AppColors.darkGreyTextColor
                            ),),
                          ),decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: !controller.isWorkNotifs.value ? Colors.white : Colors.transparent
                          ),),
                        ),

                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      gradient: greenGradiantAppBar,
                      borderRadius: BorderRadius.circular(8)
                  ),
                )),
                const Spacer(),
                const Icon(Icons.filter_alt_outlined,size: 35,color: AppColors.darkGreyTextColor,)
              ],
            ),
          ),
          Expanded(child: Obx((){
            if(controller.loading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
                itemBuilder: (context,index){
                  NotifModel model = controller.notifications[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children:  [
                            SizedBox(
                              width:85,
                              height: 85,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: LoadingImageWidget(imageName: model.image)),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.notifInfo,style: const TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                      fontSize: 17
                                  ),),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width:25,
                                        height: 25,
                                        child: SvgWidget('assets/images/pref_calendar_icon.svg'),
                                      ),
                                      Text(model.notifDate,style: const TextStyle(
                                          color: AppColors.darkGreyTextColor,
                                          fontSize: 16
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount: controller.notifications.length);
          })),
        ],
      ),
    ), onWillPop: () async{
      NotifsController.deleteInstance();
      return true;
    });
  }
}
