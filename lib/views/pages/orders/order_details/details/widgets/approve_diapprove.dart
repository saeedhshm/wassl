import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../../consts_widgets/gradiants.dart';

class ApproveDisapproveWidget extends StatelessWidget {

  final OrderDetailsController controller = Get.find();


  ApproveDisapproveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.order.statusID == 1 ? SizedBox(
      child: controller.isTeamOrder ? SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    await controller.setTeamOrderStatusRequest('2');

                    // Future.delayed(const Duration(milliseconds: 4610),(){
                    //   Get.back();
                    // });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: greenGradiantAppBarSecond,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('approved'.tr,style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: InkWell(
                  onTap: (){
                    controller.setTeamOrderStatusRequest('3');
                    // prevController.getAllOrders();
                    // prevController.getTeamOrders();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: redGradiantCancel,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('disapproved'.tr,style: TextStyle(
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
      ) : SizedBox(),
    ) : SizedBox();
  }
}
