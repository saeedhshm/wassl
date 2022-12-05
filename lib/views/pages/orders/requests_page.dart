import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/orders/pages/correcting_fingerprint.dart';
import 'package:wassl/views/pages/orders/pages/custody_leaving.dart';
import 'package:wassl/views/pages/orders/pages/custody_request.dart';
import 'package:wassl/views/pages/orders/pages/emp_request.dart';
import 'package:wassl/views/pages/orders/pages/extra_work.dart';
import 'package:wassl/views/pages/orders/pages/finance_spended_request.dart';
import 'package:wassl/views/pages/orders/pages/holday_request.dart';
import 'package:wassl/views/pages/orders/pages/letter_request.dart';
import 'package:wassl/views/pages/orders/pages/loan_order.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

import '../../reusable_widgets/main_appbar.dart';

class RequestsPage extends StatelessWidget {

  static const double titleFontSizes = 18;
  static const double itemFontSize = 17;

  static const double iconSize = 35;

  static const double gapBetweenIconAndTitle = 15;

  const RequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       children: [
         MainAppbarWidget(
           'request_type'.tr,
           onBack: () {
             Get.back();
           },
         ),
         Expanded(child: Column(
           children: [
             const SizedBox(height: 16,),
             Container(
               width: double.infinity,
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Text('finance'.tr,style: const TextStyle(
                           fontSize: titleFontSizes,
                           fontWeight: FontWeight.bold,
                           color: AppColors.darkGreyTextColor
                         ),),
                       ],
                     ),
                     InkWell(
                       onTap: (){
                         Get.to(()=>const NewLoanOrder());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/loan_type.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('loans'.tr,style: const TextStyle(
                               fontSize: itemFontSize,
                               color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                     Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                         color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         Get.to(()=>const FinanceSpendedRequest());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/money_on_hand.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('Financialـcompensation'.tr,style: const TextStyle(
                               fontSize: itemFontSize,
                               color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                   ],
                 ),
               ),
               decoration: BoxDecoration(
                 color: AppColors.borderTextFieldColor.withOpacity(0.05)
               ),
             ),
             const SizedBox(height: 16,),
             Container(
               width: double.infinity,
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Text('attend'.tr,style: const TextStyle(
                             fontSize: titleFontSizes,
                             fontWeight: FontWeight.bold,
                             color: AppColors.darkGreyTextColor
                         ),),
                       ],
                     ),
                     InkWell(
                       onTap: (){
                         Get.to(()=>const CorrectingFingerprintRequest());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/finger_print.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('correct'.tr,style: const TextStyle(
                               fontSize: itemFontSize,
                               color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                     Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         Get.to(()=>const ExtraWorkRequest());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/extra_work.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('extra_work'.tr,style: const TextStyle(
                               fontSize: itemFontSize,
                               color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                   ],
                 ),
               ),
               decoration: BoxDecoration(
                   color: AppColors.borderTextFieldColor.withOpacity(0.05)
               ),
             ),
             const SizedBox(height: 16,),
             Container(
               width: double.infinity,
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Text('others'.tr,style: const TextStyle(
                             fontSize: titleFontSizes,
                             fontWeight: FontWeight.bold,
                             color: AppColors.darkGreyTextColor
                         ),),
                       ],
                     ),
                     InkWell(
                       onTap: (){
                         Get.to(()=>const HolidayRequestPage());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/holidays.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('holidays'.tr,style: const TextStyle(
                             fontSize: itemFontSize,
                             color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                     Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         // Get.to(()=>const NewLoanOrder());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/passport.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('passport'.tr,style: const TextStyle(
                               fontSize: itemFontSize,
                               color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                     Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         Get.to(()=>const LetterRequestPage());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/letter.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('letter'.tr,style: const TextStyle(
                               fontSize: itemFontSize,
                               color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                     Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         Get.to(()=>const EmploymentRequest());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/employment.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('employment'.tr,style: const TextStyle(
                               fontSize: itemFontSize,
                               color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                     Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         Get.to(()=>const CustodyRequestPage());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/custody.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('custody'.tr,style: const TextStyle(
                               fontSize: itemFontSize,
                               color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                     Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         Get.to(()=>const CustodyLeavingOrder());
                       },
                       child: Row(
                         children: [
                           const SizedBox(
                             width:iconSize,
                             height: iconSize,
                             child: SvgWidget('assets/images/custody.svg'),
                           ),
                           const SizedBox(width: gapBetweenIconAndTitle,),
                           Text('custody_leaving'.tr,style: const TextStyle(
                               fontSize: itemFontSize,
                               color: AppColors.darkGreyTextColor
                           ),)
                         ],
                       ),

                     ),
                   ],
                 ),
               ),
               decoration: BoxDecoration(
                   color: AppColors.borderTextFieldColor.withOpacity(0.05)
               ),
             ),
           ],
         ))
       ],
      ),
    );
  }
}
