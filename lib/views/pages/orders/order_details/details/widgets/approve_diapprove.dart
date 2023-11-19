import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/reusable_widgets/dialogs_messages/awsom_dialogs.dart';

import '../../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../consts_widgets/gradiants.dart';
import '../../../../../reusable_widgets/custom_text_form_field.dart';

class ApproveDisapproveWidget extends StatelessWidget {

  final OrderDetailsController controller = Get.find();
  final commentCtrl = TextEditingController();

  ApproveDisapproveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.order.statusID == 1 ? SizedBox(
      child: controller.isTeamOrder ? SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 16,right: 16),
              child: CustomTextFormField(
                hintText: 'write_comment'.tr,
                labelText: null,
                controller: commentCtrl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {

                        // await controller.setTeamOrderStatusRequest('2');
                       final result = await controller.setTeamOrderStatusRequest('2',commentCtrl.text);

                       if(result){

                         controller.appController.loading.value = false;

                         // SnackBars.back();
                         successDialog(context,message: 'order_approved_success'.tr ,onPress: (){
                           Get.back();
                           Get.delete<OrderDetailsController>();
                         });


                       }else{
                         // Get.back();
                         // Future.delayed(Duration.zero,(){
                         //   SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
                         // });

                         controller.appController.loading.value = false;
                         errorDialog(context,message: 'something_wrong_try_again'.tr);
                       }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: greenGradiantAppBarSecond,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('approved'.tr,style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final result = await controller.setTeamOrderStatusRequest('3',commentCtrl.text);
                        if(result){

                          controller.appController.loading.value = false;

                          // SnackBars.back();
                          successDialog(context,message: 'order_disapproved_success'.tr ,onPress: (){
                            Get.back();
                            Get.delete<OrderDetailsController>();
                          });


                        }else{
                          // Get.back();
                          // Future.delayed(Duration.zero,(){
                          //   SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
                          // });

                          controller.appController.loading.value = false;
                          errorDialog(context,message: 'something_wrong_try_again'.tr);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: redGradiantCancel,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('disapproved'.tr,style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ) : const SizedBox(),
    ) : const SizedBox();
  }
}
