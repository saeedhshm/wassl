import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/models/orders/holiday.dart';
import 'package:wassl/views/reusable_widgets/icons/location_icon.dart';

import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../../models/orders/AllOrders.dart';
import '../../../../../reusable_widgets/icons/mony_on_hand.dart';
import '../../../../holidays/widgets/separator.dart';

class CountryRegionWidget extends StatelessWidget {

  final Order order;
  const CountryRegionWidget(this.order,{super.key});

  @override
  Widget build(BuildContext context) {

    if(order is HolidaysData){
      HolidaysData myOrder = order as HolidaysData;
      if((myOrder.confirmation != null && myOrder.confirmation!.isNotEmpty) && (myOrder.confirmation?.first.businessTrip != null)){
        return  Column(
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
                      width: 20,
                      child: LocationIcon(color: AppColors.darkGreyTextColor,),
                    ),
                    const SizedBox(width: 16,),
                    Text('country'.tr,style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.bold
                    ),),
                    const Text(' : '),
                    Expanded(

                      child: Text(myOrder.confirmation?.first.businessTrip?.country?.name ?? '',style: const TextStyle(
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
                      width: 20,
                      child: LocationIcon(color: AppColors.darkGreyTextColor,),
                    ),
                    const SizedBox(width: 16,),
                    Text('city'.tr,style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.bold
                    ),),
                    const Text(' : '),
                    Expanded(

                      child: Text(myOrder.confirmation?.first.businessTrip?.region?.name ?? '',style: const TextStyle(
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
                      width: 20,
                      child: SalaryMoneyOnHandIcon(color: AppColors.darkGreyTextColor,),
                    ),
                    const SizedBox(width: 16,),
                    Text('cost_per_day'.tr,style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.bold
                    ),),
                    const Text(' : '),
                    Expanded(

                      child: Text('${myOrder.confirmation?.first.costPerDay.toString()}  ${'SAR'.tr}',style: const TextStyle(
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
                      width: 20,
                      child: SalaryMoneyOnHandIcon(color: AppColors.darkGreyTextColor,),
                    ),
                    const SizedBox(width: 16,),
                    Text('total_cost'.tr,style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.bold
                    ),),
                    const Text(' : '),
                    Expanded(

                      child: Text('${myOrder.confirmation?.first.totalCost.toString()}  ${'SAR'.tr}',style: const TextStyle(
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
        );
      }
    }
    return const SizedBox();
  }
}
