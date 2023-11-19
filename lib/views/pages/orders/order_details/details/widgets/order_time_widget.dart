import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/models/orders/ask_permission.dart';

import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../reusable_widgets/icons/extra_work_icon.dart';
import '../../../../../reusable_widgets/localized_text.dart';
import '../../../../holidays/widgets/separator.dart';

class OrderTimeWidget extends StatelessWidget {

  final Order order;
  const OrderTimeWidget(this.order,{super.key});

  @override
  Widget build(BuildContext context) {
    return (order is AskPermissionsData) ? Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                //var time in var
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      children: [
                        const SizedBox(
                            width:25,
                            height: 25,
                            child: ExtraWorkIcon()),
                        const SizedBox(width: 5,),

                        Text('time_in'.tr,style: const TextStyle(fontSize: 14,color: AppColors.darkGreyTextColor),),

                        const Spacer(),
                        LocalizedText(
                          '${(order as AskPermissionsData).timeIn}'.formattedTime() ?? '--:--',
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.normal
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SeparatorWidget(),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                //var time in var
                // time out var
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      children: [
                        const SizedBox(
                            width:25,
                            height: 25,
                            child: ExtraWorkIcon()),
                        const SizedBox(width: 5,),
                        Text('time_out'.tr,
                          style: const TextStyle(fontSize: 14,color: AppColors.darkGreyTextColor),),

                        const Spacer(),
                        LocalizedText(
                          '${(order as AskPermissionsData).timeOut}'.formattedTime() ?? '--:--',
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.normal
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SeparatorWidget(),
      ],
    ) : const SizedBox();
  }
}
