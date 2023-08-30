import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wassl/getx_controllers/orders/order_details.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/approve_diapprove.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/emp_name.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/holiday_duration.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/order_time_widget.dart';
import 'package:wassl/views/pages/orders/order_details/details/widgets/order_type_widget.dart';
import 'package:wassl/views/reusable_widgets/icons/calendar_icon.dart';
import 'package:wassl/views/reusable_widgets/icons/doc_icon.dart';
import 'package:wassl/web_services_helper/urls.dart';
import '../../../../../models/orders/holiday.dart';
import '../../../../consts_widgets/loading_widgets.dart';
import '../../../../reusable_widgets/icons/chat_icon.dart';
import '../../../../reusable_widgets/icons/status_icon.dart';

class OderDetailFragment extends StatelessWidget {

   OderDetailFragment({Key? key}) : super(key: key);
   final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {


    println('$appDomain/${controller.order.file.replaceAll('public', 'storage')}','☎️');
    return Scaffold(
//first icon-- assets/images/profile/5.png
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.mainBackgroundColor,
              child: Column(
                children: [

                  EmployeeDetailsWidget(),





                  OrderTypeWidget(),


                  const SeparatorWidget(),

                  // status
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 25,
                            child:StatusOnHandIcon(),
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
                              padding:  EdgeInsets.symmetric(horizontal: 16.0,vertical:'lang_code'.tr == 'ar' ? 2 : 6),
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
                  const SeparatorWidget(),


                  // order date
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 25,
                            height: 25,
                            child:PrefCalendarIcon(),
                          ),
                          const SizedBox(width: 16,),
                          Text('date'.tr,style: const TextStyle(
                              color: AppColors.darkGreyTextColor,
                              fontWeight: FontWeight.bold
                          ),),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              // border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                                borderRadius: BorderRadius.circular(50),
                                // gradient:controller.order.statusID == 1 ? grayGradiantAwait : controller.order.statusID == 4 ? redGradiantRejected : controller.order.statusID == 3 ? redGradiantCancel : greenGradiantAppBarSecond
                            ),
                            child: Text((controller.order.orderDate).tr,style: const TextStyle(
                                color: AppColors.darkGreyTextColor,
                                fontSize: 15
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SeparatorWidget(),

                  OrderTimeWidget(controller.order),

                  //


                  //separator
                  const SeparatorWidget(),

                  // reason
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           SizedBox(
                            width: 25,
                            child: ChatConversationIcon(),
                          ),
                          const SizedBox(width: 16,),
                          Text('reason'.tr,style: const TextStyle(
                              color: AppColors.darkGreyTextColor,
                              fontWeight: FontWeight.bold
                          ),),
                          const Text(' : '),
                          Expanded(

                            child: Text((controller.order.reason ?? '').tr,style: const TextStyle(
                                color: AppColors.darkGreyTextColor,
                                fontSize: 16
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SeparatorWidget(),

                  SizedBox(height: (controller.order is HolidaysData) ? 50 : 10,),

                  HolidayDurationWidget(),

                  controller.order.file.isNotEmpty ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(onPressed: (){
                        launchUrlString('$appDomain/${controller.order.file.replaceAll('public', 'storage')}');
                      }, child: Row(

                        children: [
                          const Icon(Icons.download),
                          const SizedBox(width: 15,),
                          Text('download_file'.tr)
                        ],
                      )),
                    ],
                  ) :SizedBox()
                ],
              ),

            ),
          ),
          // controller.order.statusID == 1
          ApproveDisapproveWidget()
        ],
      ),
    );
  }
}

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.maxFinite,
        height: 1,
        color: AppColors.borderTextFieldColor,
      ),
    );
  }
}
