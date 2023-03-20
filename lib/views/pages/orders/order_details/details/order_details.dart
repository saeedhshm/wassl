import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/order_details.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/models/orders/finger_print.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';

import '../../../../../helpers/constants/print_ln.dart';
import '../../../../../models/orders/holiday.dart';

class OderDetailFragment extends StatelessWidget {

   OderDetailFragment({Key? key}) : super(key: key);
   final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    println('======>>>> order: ${controller.order.orderID}, ${controller.order.orderType}, ${controller.order.orderStatus}');
    return Scaffold(
//first icon-- assets/images/profile/5.png
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.mainBackgroundColor,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 25,
                            child: Image.asset('assets/images/order_details/Untitled.png'),
                          ),
                          SizedBox(width: 16,),
                          Text('order_type'.tr,style: TextStyle(
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
                              child: Text(controller.order.orderType.tr,style: TextStyle(
                                color: AppColors.mainGreenColor,
                                fontSize: 12
                              ),),
                            ),
                          ),
                          SizedBox(width: 16,),
                          (controller.order is HolidaysData) ?   Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text((controller.order as HolidaysData).holidayType ,style: TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontSize: 12
                              ),),
                            ),
                          )
                          : (controller.order is FingerprintCorrectionsData) ?  Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text((controller.order as FingerprintCorrectionsData).workingType?.name ?? '' ,style: TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontSize: 12
                              ),),
                            ),
                          ) : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.maxFinite,
                      height: 1,
                      color: AppColors.borderTextFieldColor,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 25,
                            child: Image.asset('assets/images/order_details/status.png'),
                          ),
                          const SizedBox(width: 16,),
                          Text('status'.tr,style: const TextStyle(
                              color: AppColors.darkGreyTextColor,
                              fontWeight: FontWeight.bold
                          ),),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                // border: Border.all(color: AppColors.mainGreenColor,width: 0.5),
                                borderRadius: BorderRadius.circular(50),
                              gradient:controller.order.statusID == 1 ? grayGradiantAwait : controller.order.statusID == 4 ? redGradiantCancel : greenGradiantAppBarSecond
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text((controller.order.status?.statusAr ?? '').tr,style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                              ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.maxFinite,
                      height: 1,
                      color: AppColors.borderTextFieldColor,
                    ),
                  ),
                  SizedBox(height: 50,),
                  (controller.order is HolidaysData) ?   Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.maxFinite,
                          height: 1,
                          color: AppColors.borderTextFieldColor,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 25,
                                child: Image.asset('assets/images/order_details/calendar.png'),
                              ),
                              SizedBox(width: 16,),
                              Text('holiday_time'.tr,style: TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold
                              ),),
                              Spacer(),

                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(((controller.order as HolidaysData).differenceInDays),style: TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                      fontSize: 12
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.maxFinite,
                          height: 1,
                          color: AppColors.borderTextFieldColor,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(((controller.order as HolidaysData).holidayStart ?? ''),style: TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold
                              ),),
                              SizedBox(width: 16,),
                              SizedBox(
                                width: 25,
                                child: Image.asset('assets/images/order_details/arrow.png'),
                              ),
                              SizedBox(width: 16,),
                              Text(((controller.order as HolidaysData).holidayEnd ?? ''),style: TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold
                              ),),
                              Spacer(),


                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.maxFinite,
                          height: 1,
                          color: AppColors.borderTextFieldColor,
                        ),
                      ),
                    ],
                  ) : SizedBox(),
                ],
              ),

            ),
          ),
         controller.order.statusID == 1 ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
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
                SizedBox(width: 20,),
                Expanded(
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
                )
              ],
            ),
          ) : SizedBox()
        ],
      ),
    );
  }
}
