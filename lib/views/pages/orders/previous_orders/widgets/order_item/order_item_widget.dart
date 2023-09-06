import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets/order_item/widgets/name.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets/order_item/widgets/order_type_name.dart';

import '../../../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../../helpers/exceptions/no_internet.dart';
import '../../../../../../models/orders/AllOrders.dart';
import '../../../../../../models/orders/ask_permission.dart';
import '../../../../../../models/orders/financial_expenses.dart';
import '../../../../../../models/orders/finger_print.dart';
import '../../../../../../models/orders/holiday.dart';
import '../../../../../../models/orders/letter.dart';
import '../../../../../../models/orders/loan_order.dart';
import '../../../../../../models/orders/over_time.dart';
import '../../../../../../models/orders/tabreer.dart';
import '../../../../../../models/orders/visa_order.dart';
import '../../../../../reusable_widgets/icons/calendar_icon.dart';
import '../../../../../reusable_widgets/snack_bars.dart';
import '../../../pages/ask_permission.dart';
import '../../../pages/correcting_fingerprint.dart';
import '../../../pages/custody_request.dart';
import '../../../pages/extra_work.dart';
import '../../../pages/finance_spended_request.dart';
import '../../../pages/holday_request.dart';
import '../../../pages/letter_request.dart';
import '../../../pages/loan_order.dart';
import '../../../pages/tabreer_request.dart';
import '../../../pages/visa_request.dart';

class OrderItemWidget extends StatelessWidget {

  final Order order;

  const OrderItemWidget({Key? key,required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
        child: Column(
          children: [
            //Order type name
            OrderTypeName(order),
            //employee name
            EmpNameWidget(nameEmployee:order.nameEmployee?.fullName ,),

            //Visa type
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
                  child: PrefCalendarIcon(),
                ),
                Text((order.orderName == 'OrderVisaData' ? '${'required_before'.tr} : ' : '') + order.orderDate,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontSize: 16
                ),)
              ],
            ),
            (order.orderName == 'OrderVisaData' && (order as OrderVisaData).hasTicket) ? Row(
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

                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget('${'holiday'.tr} ${(order as HolidaysData).holidayType}'.tr),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget(((order as HolidaysData).differenceInDays)),
                ),
              ],
            ) : const SizedBox(),
            order.orderName == 'FingerprintCorrectionsData' ? Row(
              children: [

                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget('request'.tr + ' : '+ ((order as FingerprintCorrectionsData).type?.name ?? '')),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget('time'.tr + ' : '+ ((order as FingerprintCorrectionsData).time ?? '').timeFromTimeSelection),
                ),
              ],
            ) : const SizedBox(),
            order.orderName == 'FinancialExpensesDate' ? Row(
              children: [

                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget((order as FinancialExpensesDate).name ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget(((order as FinancialExpensesDate).amount.toString() + ' ' + 'SAR'.tr)),
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
                  child: NewWidget((order as LoansData).loanType),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget((order as LoansData).amount.toString()  + ' ' + 'SAR'.tr),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget(((order as LoansData).installmentAmount.toString() + ' ' + 'SAR'.tr)),
                ),
              ],
            ) : const SizedBox(),
            order.orderName == 'LetterDate' ? Row(
              children: [

                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget((order as LetterDate).letterType  + ' ' + 'SAR'.tr),
                ),
                const SizedBox(width: 20,),

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
                  child: NewWidget((order as AskPermissionsData).type?.name ?? ''),
                ),
                const SizedBox(width: 20,),

                Expanded(
                  child: NewWidget((order as AskPermissionsData).reasonType?.name ?? ''),
                ),
              ],
            ) : const SizedBox(),

            order.orderName == 'OvertimeData' ? Row(
              children: [

                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget('starts'.tr + ((order as OvertimeData).startTime ?? '').timeFromTimeSelection.tr),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget('ends'.tr + ((order as OvertimeData).endTime ?? '').timeFromTimeSelection),
                ),
              ],
            ) : const SizedBox(),

            order.orderName == 'ApologyData' ? Row(
              children: [

                const SizedBox(width: 20,),
                Expanded(
                  child: NewWidget((order as ApologyData).type?.name ?? '' ),
                ),
                const SizedBox(width: 20,),

              ],
            ) : const SizedBox(),
            Row(
              children: [
                const Spacer(),
                (order.statusID == 1) && (order.nameEmployee == null)  ? InkWell(
                    onTap: updateOrder,
                    child: const Icon(Icons.mode_edit_outline_sharp,color: AppColors.mainGreenColor,size: 18,)) : const SizedBox(),
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

  void updateOrder(){

    if(order.confirmation != null){
      for(Confirmation c in order.confirmation!){
        var status =  c.status ?? 0;
        if(status == 2){
          SnackBars.showErrorSnackBar('under_approve'.tr, 'this_order_approved_from_one'.tr);
          return;
        }

      }
    }

    switch(order.orderName){
      case 'AskPermissionsData':
        Get.to(()=> AskPermissionPage(order: order,onClose: getAllOrdersAfterUpdate,));
        break;
      case 'CustodyDate':
        Get.to(()=> CustodyRequestPage(order: order,onClose:getAllOrdersAfterUpdate,));
        break;
      case 'FinancialExpensesDate':
        Get.to(()=> FinanceSpendedRequest(order: order,onClose: getAllOrdersAfterUpdate,));
        break;
      case 'FingerprintCorrectionsData':
        Get.to(()=> CorrectingFingerprintRequest(order: order,onClose:getAllOrdersAfterUpdate,));
        break;
      case 'HolidaysData':
        Get.to(()=> HolidayRequestPage(order: order,onClose:getAllOrdersAfterUpdate,));
        break;
      case 'LetterDate':
        Get.to(()=> LetterRequestPage(order: order,onClose: getAllOrdersAfterUpdate,));
        break;
      case 'LoansData':
        Get.to(()=> NewLoanOrder(order: order,onClose: getAllOrdersAfterUpdate,));
        break;
      case 'OvertimeData':
        Get.to(()=> ExtraWorkRequest(order: order,onClose: getAllOrdersAfterUpdate,));
        break;
      case 'OrderVisaData':
        Get.to(()=> VisaRequestPage(order: order,onClose: getAllOrdersAfterUpdate,));
        break;
      case 'ApologyData':
        Get.to(()=> ApologyRequestPage(order: order,onClose: getAllOrdersAfterUpdate,));
        break;

    }
  }

  getAllOrdersAfterUpdate(){

    final PreviousRequestsController controller = Get.find();
    Future.delayed(Duration.zero,()async{
      try{
        await controller.getMyOrders();
      }on NoDataAvailableException catch (e){

      }finally{
        controller.appController.loading.value = false;
      }
    });

  }
}

class NewWidget extends StatelessWidget {
  const NewWidget(
      this.title,{
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
            style: const TextStyle(
                color: Colors.white
            ),),
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.orangeColorInCalend,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
