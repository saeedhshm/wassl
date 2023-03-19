import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/order_details.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../../../consts_widgets/gradiants.dart';
import 'confirm_chain/chain.dart';
import 'details/order_details.dart';

class OrderDetailsPage extends StatelessWidget {

   OrderDetailsPage({Key? key}) : super(key: key);
   final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: Obx(()=>Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: greenGradiantAppBarSecond
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16,top: 50),
              child: Row(
                children: [
                  Text(controller.order.orderType.tr,style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
                  const Spacer(),
                  InkWell(onTap:(){
                    Get.delete<OrderDetailsController>();
                    Get.back();
                  },child: Icon(Icons.arrow_forward,color: Colors.white,)),
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
      )),
    ), onWillPop: ()async{
      Get.delete<OrderDetailsController>();
      Get.back();
      return true;
    });
  }
}
