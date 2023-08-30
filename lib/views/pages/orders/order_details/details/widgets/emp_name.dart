import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../../helpers/constants/app_colors.dart';

class EmployeeDetailsWidget extends StatelessWidget {

  EmployeeDetailsWidget({super.key});
  final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        controller.order.nameEmployee != null ? Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                  child: Image.asset('assets/images/profile/1.png'),
                ),
                const SizedBox(width: 16,),
                Text('emp_name'.tr,style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.bold
                ),),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainGreenColor,width: 0.5),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(controller.order.nameEmployee?.fullName ?? '',style: const TextStyle(
                        color: AppColors.mainGreenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),),
                  ),
                ),

              ],
            ),
          ),
        ) : const SizedBox(),
        controller.order.nameEmployee != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.maxFinite,
            height: 1,
            color: AppColors.borderTextFieldColor,
          ),
        ) : const SizedBox(),
      ],
    );
  }
}
