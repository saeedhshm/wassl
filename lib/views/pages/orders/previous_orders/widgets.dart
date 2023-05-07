import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

import '../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/print_ln.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/ask_permission.dart';
import '../../../../models/orders/financial_expenses.dart';
import '../../../../models/orders/finger_print.dart';
import '../../../../models/orders/holiday.dart';
import '../../../../models/orders/letter.dart';
import '../../../../models/orders/loan_order.dart';
import '../../../../models/orders/over_time.dart';
import '../../../../models/orders/visa_order.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/gradiant_text.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../pages/ask_permission.dart';
import '../pages/correcting_fingerprint.dart';
import '../pages/custody_request.dart';
import '../pages/extra_work.dart';
import '../pages/finance_spended_request.dart';
import '../pages/holday_request.dart';
import '../pages/letter_request.dart';
import '../pages/loan_order.dart';
import '../pages/visa_request.dart';

class PreviousRequestsItemWidget extends StatelessWidget {

  final Order order;

  const PreviousRequestsItemWidget({Key? key,required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.orderName.tr,style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                    order.orderName == 'LetterDate' ?  Text('directed_to'.tr + ' : ' +((order as LetterDate).directedToAr ?? ''),style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15
                    ),) : const SizedBox(),
                    order.orderName == 'LoansData' ?  Text('installment_method'.tr + ' : ' +((order as LoansData).monthlyInstallment ?? ''),style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15
                    ),) : const SizedBox(),

                    // Spacer(),

                  ],
                )),
                GradientText(order.orderStatus.tr,style: TextStyle(  ),
                    gradient:order.statusID == 1 ? grayGradiantAwait : order.statusID == 4 ? redGradiantRejected : order.statusID == 3 ? redGradiantCancel : greenGradiantAppBarSecond
                )
              ],
            ),

            order.orderName == 'OrderVisaData' ?  Row(
              children: [
                Text('visa_type'.tr + ' : ' +((order as OrderVisaData).visaType ),style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 13
                ),),
                const Spacer(),
                Text(((order as OrderVisaData).ticketType ),style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 13
                ),),
              ],
            ) : const SizedBox(),
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                  height: 25,
                  child: SvgWidget('assets/images/pref_calendar_icon.svg'),
                ),
                Text((order.orderName == 'OrderVisaData' ? '${'required_before'.tr} : ' : '') + order.orderDate,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontSize: 16
                ),)
              ],
            ),
            (order.orderName == 'OrderVisaData' &&(order as OrderVisaData).hasTicket) ? Row(
              children: [
                const SizedBox(
                  width: 25,
                  height: 25,
                  child: Icon(Icons.flight_takeoff_outlined,color: AppColors.lightGreyTextColor,),
                  // child: SvgWidget('assets/images/pref_calendar_icon.svg'),
                ),
                const SizedBox(width: 5,),
                Text((order as OrderVisaData).goDate ?? '',style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 14
                ),),
                const Spacer(),
                (order as OrderVisaData).hasBackTicket ?  const SizedBox(
                  width: 25,
                  height: 25,
                  child: Icon(Icons.flight_land_outlined,color: AppColors.lightGreyTextColor,),
                  // child: SvgWidget('assets/images/pref_calendar_icon.svg'),
                ) : const SizedBox(),
                const SizedBox(width: 5,),
                (order as OrderVisaData).hasBackTicket ? Text( (order as OrderVisaData).backDate ?? '',style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 14
                ),) : const SizedBox(),


              ],
            ) : const SizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('reason'.tr + ': ',style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                ),),
                Expanded(child: Text(order.reason.tr,style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                ),))
              ],
            ),
            const SizedBox(height: 10,),
            order.orderName == 'HolidaysData' ? Row(
              children: [
                Text('start'.tr + ' : '+ ((order as HolidaysData).holidayStart ?? ''),style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                ),),
                const Spacer(),
                Text('end'.tr + ' : '+ ((order as HolidaysData).holidayEnd ?? ''),style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                ),),
              ],
            ) : const SizedBox(),

            order.orderName == 'HolidaysData' ? Row(
              children: [
                // Expanded(
                //   child: Container(
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text('whole_day'.tr,
                //         style: TextStyle(
                //           color: AppColors.darkGreyTextColor
                //         ),),
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.mainBackgroundColor,
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${'holiday'.tr} ${(order as HolidaysData).holidayType}'.tr,
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(((order as HolidaysData).differenceInDays),
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ) : const SizedBox(),
            order.orderName == 'FingerprintCorrectionsData' ? Row(
              children: [
                // Expanded(
                //   child: Container(
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text('whole_day'.tr,
                //         style: TextStyle(
                //           color: AppColors.darkGreyTextColor
                //         ),),
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.mainBackgroundColor,
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('request'.tr + ' : '+ ((order as FingerprintCorrectionsData).type?.name ?? ''),
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('time'.tr + ' : '+ ((order as FingerprintCorrectionsData).time ?? '').timeFromTimeSelection,
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ) : const SizedBox(),
            order.orderName == 'FinancialExpensesDate' ? Row(
              children: [
                // Expanded(
                //   child: Container(
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text('whole_day'.tr,
                //         style: TextStyle(
                //           color: AppColors.darkGreyTextColor
                //         ),),
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.mainBackgroundColor,
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((order as FinancialExpensesDate).name ?? '',
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(((order as FinancialExpensesDate).amount.toString() + ' ' + 'SAR'.tr),
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ) : const SizedBox(),
            order.orderName == 'LoansData' ? Row(
              children: [
                Expanded(
                  child: Text('type'.tr + ' : ',style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15
                  ),),
                ),
                Expanded(
                  child: Text('loan'.tr + ' ',style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15
                  ),),
                ),
                Expanded(
                  child: Text('installment'.tr + ' : ',style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15
                  ),),
                ),
              ],
            ) : const SizedBox(),
            order.orderName == 'LoansData' ? Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((order as LoansData).loanType,
                        style: const TextStyle(
                          color: AppColors.darkGreyTextColor
                        ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((order as LoansData).amount.toString()  + ' ' + 'SAR'.tr,
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(((order as LoansData).installmentAmount.toString() + ' ' + 'SAR'.tr),
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ) : const SizedBox(),
            order.orderName == 'LetterDate' ? Row(
              children: [
                // Expanded(
                //   child: Container(
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text('whole_day'.tr,
                //         style: TextStyle(
                //           color: AppColors.darkGreyTextColor
                //         ),),
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.mainBackgroundColor,
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((order as LetterDate).letterType  + ' ' + 'SAR'.tr,
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                // Expanded(
                //   child: Container(
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(((order as LoansData).installmentAmount.toString() + ' ' + 'SAR'.tr),
                //           style: const TextStyle(
                //               color: AppColors.darkGreyTextColor
                //           ),),
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.mainBackgroundColor,
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
              ],
            ) : const SizedBox(),
            order.orderName == 'AskPermissionsData' ? Row(
              children: [
                Expanded(
                  child: Text('type'.tr + ' : ',style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15
                  ),),
                ),
                // Expanded(
                //   child: Text('loan'.tr + ' : ',style: const TextStyle(
                //       color: AppColors.darkGreyTextColor,
                //       fontWeight: FontWeight.normal,
                //       fontSize: 15
                //   ),),
                // ),
                Expanded(
                  child: Text('reason_type'.tr + ' : ',style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15
                  ),),
                ),
              ],
            ) : const SizedBox(),
            order.orderName == 'AskPermissionsData' ? Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((order as AskPermissionsData).type?.name ?? '',
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                // Expanded(
                //   child: Container(
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text((order as LoansData).amount.toString()  + ' ' + 'SAR'.tr,
                //           style: const TextStyle(
                //               color: AppColors.darkGreyTextColor
                //           ),),
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.mainBackgroundColor,
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
                // const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((order as AskPermissionsData).reasonType?.name ?? '' ,
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ) : const SizedBox(),

            order.orderName == 'OvertimeData' ? Row(
              children: [
                // Expanded(
                //   child: Container(
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text('whole_day'.tr,
                //         style: TextStyle(
                //           color: AppColors.darkGreyTextColor
                //         ),),
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.mainBackgroundColor,
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('starts'.tr + ((order as OvertimeData).startTime ?? '').timeFromTimeSelection.tr,
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('ends'.tr + ((order as OvertimeData).endTime ?? '').timeFromTimeSelection,
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ) : const SizedBox(),
            Row(
              children: [
                Spacer(),
                order.statusID == 1 ? InkWell(
                    onTap: (){
                      if(order.statusID == 1){
                        switch(order.orderName){
                          case 'AskPermissionsData':
                            Get.to(()=> AskPermissionPage(order: order,onClose: (){
                              final PreviousRequestsController controller = Get.find();
                              Future.delayed(Duration.zero,()async{
                                try{
                                  await controller.getAllOrders();
                                }on NoDataAvailableException catch (e){
                                  println('============ getall orders =========');
                                  println(e);
                                  println('============ getall orders =========getall orders =========');
                                }finally{
                                  controller.appController.loading.value = false;
                                }
                              });
                            },));
                            break;
                          case 'CustodyDate':
                            Get.to(()=> CustodyRequestPage(order: order,onClose: (){
                              final PreviousRequestsController controller = Get.find();
                              Future.delayed(Duration.zero,()async{
                                try{
                                  await controller.getAllOrders();
                                }on NoDataAvailableException catch (e){
                                  println('============ getall orders =========');
                                  println(e);
                                  println('============ getall orders =========getall orders =========');
                                }finally{
                                  controller.appController.loading.value = false;
                                }
                              });
                            },));
                            break;
                          case 'FinancialExpensesDate':
                            Get.to(()=> FinanceSpendedRequest(order: order,onClose: (){
                              final PreviousRequestsController controller = Get.find();
                              Future.delayed(Duration.zero,()async{
                                try{
                                  await controller.getAllOrders();
                                }on NoDataAvailableException catch (e){
                                  println('============ getall orders =========');
                                  println(e);
                                  println('============ getall orders =========getall orders =========');
                                }finally{
                                  controller.appController.loading.value = false;
                                }
                              });
                            },));
                            break;
                          case 'FingerprintCorrectionsData':
                            Get.to(()=> CorrectingFingerprintRequest(order: order,onClose: (){
                              final PreviousRequestsController controller = Get.find();
                              Future.delayed(Duration.zero,()async{
                                try{
                                  await controller.getAllOrders();
                                }on NoDataAvailableException catch (e){
                                  println('============ getall orders =========');
                                  println(e);
                                  println('============ getall orders =========getall orders =========');
                                }finally{
                                  controller.appController.loading.value = false;
                                }
                              });
                            },));
                            break;
                          case 'HolidaysData':
                            Get.to(()=> HolidayRequestPage(order: order,onClose: (){
                              final PreviousRequestsController controller = Get.find();
                              Future.delayed(Duration.zero,()async{
                                try{
                                  await controller.getAllOrders();
                                }on NoDataAvailableException catch (e){
                                  println('============ getall orders =========');
                                  println(e);
                                  println('============ getall orders =========getall orders =========');
                                }finally{
                                  controller.appController.loading.value = false;
                                }
                              });
                            },));
                            break;
                          case 'LetterDate':
                            Get.to(()=> LetterRequestPage(order: order,onClose: (){
                              final PreviousRequestsController controller = Get.find();
                              Future.delayed(Duration.zero,()async{
                                try{
                                  await controller.getAllOrders();
                                }on NoDataAvailableException catch (e){
                                  println('============ getall orders =========');
                                  println(e);
                                  println('============ getall orders =========getall orders =========');
                                }finally{
                                  controller.appController.loading.value = false;
                                }
                              });
                            },));
                            break;
                          case 'LoansData':
                            Get.to(()=> NewLoanOrder(order: order,onClose: (){
                              final PreviousRequestsController controller = Get.find();
                              Future.delayed(Duration.zero,()async{
                                try{
                                  await controller.getAllOrders();
                                }on NoDataAvailableException catch (e){
                                  println('============ getall orders =========');
                                  println(e);
                                  println('============ getall orders =========getall orders =========');
                                }finally{
                                  controller.appController.loading.value = false;
                                }
                              });
                            },));
                            break;
                          case 'OvertimeData':
                            Get.to(()=> ExtraWorkRequest(order: order,onClose: (){
                              final PreviousRequestsController controller = Get.find();
                              Future.delayed(Duration.zero,()async{
                                try{
                                  await controller.getAllOrders();
                                }on NoDataAvailableException catch (e){
                                  println('============ getall orders =========');
                                  println(e);
                                  println('============ getall orders =========getall orders =========');
                                }finally{
                                  controller.appController.loading.value = false;
                                }
                              });
                            },));
                            break;
                          case 'OrderVisaData':
                            Get.to(()=> VisaRequestPage(order: order,onClose: (){
                              final PreviousRequestsController controller = Get.find();
                              Future.delayed(Duration.zero,()async{
                                try{
                                  await controller.getAllOrders();
                                }on NoDataAvailableException catch (e){
                                  println('============ getall orders =========');
                                  println(e);
                                  println('============ getall orders =========getall orders =========');
                                }finally{
                                  controller.appController.loading.value = false;
                                }
                              });
                            },));
                            break;

                        }
                      }else{
                        SnackBars.showErrorSnackBar('error'.tr, 'cannot_update_order'.tr);
                      }
                    },child: Icon(Icons.mode_edit_outline_sharp,color: AppColors.mainGreenColor,size: 18,)) : SizedBox(),
              ],
            )

          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
