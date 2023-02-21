import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/ask_permission.dart';
import '../../../../models/orders/financial_expenses.dart';
import '../../../../models/orders/finger_print.dart';
import '../../../../models/orders/holiday.dart';
import '../../../../models/orders/letter.dart';
import '../../../../models/orders/loan_order.dart';

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
                    Text(order.orderType.tr,style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                    order.orderType == 'LetterDate' ?  Text('directed_to'.tr + ' : ' +((order as LetterDate).directedToAr ?? ''),style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15
                    ),) : const SizedBox(),
                    order.orderType == 'LoansData' ?  Text('installment_method'.tr + ' : ' +((order as LoansData).monthlyInstallment ?? ''),style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15
                    ),) : const SizedBox(),
                  ],
                )),
                Text(order.orderStatus.tr,style: TextStyle(
                  color: order.orderStatus == 'not_confirmed' ? Colors.red : AppColors.mainGreenColor
                ),)
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                  height: 25,
                  child: SvgWidget('assets/images/pref_calendar_icon.svg'),
                ),
                Text(order.orderDate,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontSize: 16
                ),)
              ],
            ),
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
            order.orderType == 'HolidaysData' ? Row(
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

            order.orderType == 'HolidaysData' ? Row(
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
            order.orderType == 'FingerprintCorrectionsData' ? Row(
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
                        child: Text('request'.tr + ' : '+ ((order as FingerprintCorrectionsData).workingType ?? ''),
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
                        child: Text('time'.tr + ' : '+ ((order as FingerprintCorrectionsData).time ?? ''),
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
            order.orderType == 'FinancialExpensesDate' ? Row(
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
            order.orderType == 'LoansData' ? Row(
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
            order.orderType == 'LoansData' ? Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((order as LoansData).loanType,
                        style: TextStyle(
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
            order.orderType == 'LetterDate' ? Row(
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
            order.orderType == 'AskPermissionsData' ? Row(
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
            order.orderType == 'AskPermissionsData' ? Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((order as AskPermissionsData).type?.name ?? '',
                          style: TextStyle(
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
