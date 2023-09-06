import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import '../../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../../consts_widgets/gradiants.dart';
import '../../../../../reusable_widgets/custom_text_form_field.dart';

class ApproveDisapproveWidget extends StatelessWidget {

  final OrderDetailsController controller = Get.find();
  final userNameCtrl = TextEditingController();

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
                controller: userNameCtrl,
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
                      onTap: (){
                        println(userNameCtrl.text);
                        controller.setTeamOrderStatusRequest('3',userNameCtrl.text);
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
      ) : SizedBox(),
    ) : SizedBox();
  }
}
