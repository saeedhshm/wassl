import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/models/orders/letter.dart';

import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../reusable_widgets/icons/doc_icon.dart';
import '../../../../holidays/widgets/separator.dart';

class DirectedToWidget extends StatelessWidget {
  final Order order;
  const DirectedToWidget(this.order,{super.key});

  @override
  Widget build(BuildContext context) {
    return (order is LetterDate ) ? Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 25,
                  child: DocIcon(color: AppColors.lightGreyTextColor,),
                ),
                const SizedBox(width: 16,),

                Text('foreword_to_ar'.tr,style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.bold
                ),),
                const Text(' : '),
                Expanded(

                  child: Text((order as LetterDate ).directedToAr ?? '',style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontSize: 16
                  ),),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 25,
                  child: DocIcon(color: AppColors.lightGreyTextColor,),
                ),
                const SizedBox(width: 16,),

                Text('foreword_to_en'.tr,style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.bold
                ),),
                const Text(' : '),
                Expanded(

                  child: Text((order as LetterDate ).directedToEn ?? '',style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontSize: 16
                  ),),
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
