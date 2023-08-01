import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/order_details.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../../../../getx_controllers/orders/previous_requests.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../consts_widgets/loading_widgets.dart';
import 'confirm_chain/chain.dart';
import 'details/order_details.dart';

class OrderDetailsPage extends StatelessWidget {


   OrderDetailsPage({Key? key}) : super(key: key);
   final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {


    return WillPopScope(child: Scaffold(
      body: Obx(()=>Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: greenGradiantAppBarSecond
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16,top: 50),
                  child: Row(
                    children: [
                      Text(controller.order.orderName.tr,style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                      const Spacer(),
                      InkWell(onTap:(){
                        Get.delete<OrderDetailsController>();
                        Get.back();
                      },child: Image.asset(
                        'assets/images/back_arrow_${'lang_code'.tr}.png',
                        width: 50,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          controller.orderDetailsTapSelected.value = true;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color:controller.orderDetailsTapSelected.value ? AppColors.mainGreenColor : AppColors.borderTextFieldColor,width: 1))
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('order_details'.tr,style: TextStyle(
                                  color: controller.orderDetailsTapSelected.value ? AppColors.mainGreenColor : AppColors.darkGreyTextColor
                              ),),
                            ),
                          ),
                        ),
                      )),
                      Expanded(child: InkWell(
                        onTap: (){
                          controller.orderDetailsTapSelected.value = false;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: !controller.orderDetailsTapSelected.value ? AppColors.mainGreenColor : AppColors.borderTextFieldColor,width: 1))
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('confirm_chain'.tr,style: TextStyle(
                                  color: !controller.orderDetailsTapSelected.value ? AppColors.mainGreenColor : AppColors.darkGreyTextColor
                              ),),
                            ),
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
              Expanded(child: controller.orderDetailsTapSelected.value ? OderDetailFragment() : ConfirmChainFragment())

            ],
          ),
          Obx(() => SizedBox(
            child: controller.appController.loading.value ? WaitingRequestLoadingWidget( ):SizedBox(),
          )),
        ],
      )),
    ), onWillPop: ()async{

      Get.delete<OrderDetailsController>();
      Get.back();
      return true;
    });
  }
}
