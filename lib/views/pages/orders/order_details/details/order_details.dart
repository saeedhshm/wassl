import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/order_details.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/approve_diapprove.dart';
import '../../../../../models/orders/holiday.dart';
import '../../../../consts_widgets/loading_widgets.dart';

class OderDetailFragment extends StatelessWidget {

   OderDetailFragment({Key? key}) : super(key: key);
   final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
//first icon-- assets/images/profile/5.png
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.mainBackgroundColor,
                  child: Column(
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
                              SizedBox(width: 16,),
                              Text('emp_name'.tr,style: TextStyle(
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
                                  child: Text(controller.order.orderName.tr,style: const TextStyle(
                                    color: AppColors.mainGreenColor,
                                    fontSize: 12
                                  ),),
                                ),
                              ),
                              SizedBox(width: controller.order.type?.name != null ? 16 : 0,),
                              (controller.order is HolidaysData) ?   Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(controller.order.type?.name ?? '' ,style: const TextStyle(
                                      color: AppColors.darkGreyTextColor,
                                      fontSize: 12
                                  ),),
                                ),
                              )
                              : controller.order.type?.name != null ?  Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(controller.order.type?.name ?? '' ,style: const TextStyle(
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
                                  gradient:controller.order.statusID == 1 ? grayGradiantAwait : controller.order.statusID == 4 ? redGradiantRejected : controller.order.statusID == 3 ? redGradiantCancel : greenGradiantAppBarSecond
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
                      const SizedBox(height: 50,),
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
                                  const SizedBox(width: 16,),
                                  Text('holiday_time'.tr,style: const TextStyle(
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
                                      child: Text(((controller.order as HolidaysData).differenceInDays),style: const TextStyle(
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
              // controller.order.statusID == 1
              ApproveDisapproveWidget()
            ],
          ),
          Obx(() => SizedBox(
            child: controller.appController.loading.value ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: SendingLoadingWidget(),
              ),
            ):SizedBox(),
          )),
        ],
      ),
    );
  }
}
