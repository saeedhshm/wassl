import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
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

  static const double iconSize = 30;

  static const double gapBetweenIconAndTitle = 15;

   RequestsPage({Key? key}) : super(key: key);

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       children: [
         MainAppbarWidget("request_type",onBack: (){
           Get.back();
         },),
         // MainAppbarWidget(
         //   'request_type'.tr,
         //   // onBack: () {
         //   //   Get.back();
         //   // },
         // ),
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
                         Get.to(()=> NewLoanOrder());
                       },
                       child: ItemWidget(icon: 'assets/images/loan_type.svg',title: 'loans'.tr,),

                     ),
                     appController.deployingForApple ? const SizedBox() :  Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                         color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     appController.deployingForApple ? const SizedBox() : InkWell(
                       onTap: (){
                         Get.to(()=>const FinanceSpendedRequest());
                       },
                       child:ItemWidget(icon: 'assets/images/money_on_hand.svg',title: 'Financialـcompensation'.tr,),

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
                         Get.to(()=> CorrectingFingerprintRequest());
                       },
                       child: ItemWidget(icon: 'assets/images/finger_print.svg',title: 'correct'.tr,),

                     ),
                     appController.deployingForApple ? const SizedBox() : Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     appController.deployingForApple ? const SizedBox() : InkWell(
                       onTap: (){
                         Get.to(()=>const ExtraWorkRequest());
                       },
                       child:ItemWidget(icon: 'assets/images/extra_work.svg',title: 'extra_work'.tr,),

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
                         Get.to(()=> HolidayRequestPage());
                       },
                       child:ItemWidget(icon: 'assets/images/holidays.svg',title: 'holidays'.tr,),

                     ),
                     appController.deployingForApple ? const SizedBox() : Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     appController.deployingForApple ? const SizedBox() : InkWell(
                       onTap: (){
                         // Get.to(()=>const NewLoanOrder());
                       },
                       child:ItemWidget(icon: 'assets/images/passport.svg',title: 'passport'.tr,),

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
                         Get.to(()=> LetterRequestPage());
                       },
                       child:ItemWidget(icon: 'assets/images/letter.svg',title: 'letter'.tr,),

                     ),
                     appController.deployingForApple ? const SizedBox() : Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     appController.deployingForApple ? const SizedBox() : InkWell(
                       onTap: (){
                         Get.to(()=>const EmploymentRequest());
                       },
                       child:ItemWidget(icon: 'assets/images/employment.svg',title: 'employment'.tr,),

                     ),
                     appController.deployingForApple ? const SizedBox() :  Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     appController.deployingForApple ? const SizedBox() : InkWell(
                       onTap: (){
                         Get.to(()=>const CustodyRequestPage());
                       },
                       child:ItemWidget(icon: 'assets/images/custody.svg',title: 'custody'.tr,),

                     ),
                     appController.deployingForApple ? const SizedBox() : Container(
                       width: double.infinity,
                       height: 0.5,
                       decoration: BoxDecoration(
                           color: Colors.grey.withOpacity(0.1)
                       ),
                     ),
                     appController.deployingForApple ? const SizedBox() : InkWell(
                       onTap: (){
                         Get.to(()=>const CustodyLeavingOrder());
                       },
                       child:ItemWidget(icon: 'assets/images/custody.svg',title: 'custody_leaving'.tr,),

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

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.icon,
    required this.title
  }) : super(key: key);

final String icon;
final String title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
           SizedBox(
            width:30,
            height: 30,
            child: SvgWidget(icon),
          ),
           SizedBox(width: 15,),
          Text(title,style:  TextStyle(
              fontSize: 17,
              color: AppColors.darkGreyTextColor
          ),)
        ],
      ),
    );
  }
}
