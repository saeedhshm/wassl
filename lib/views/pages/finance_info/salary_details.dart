import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/finance_info/detials_widgets/net_salary_widget.dart';

import '../../../getx_controllers/finance/all_salaries.dart';
import '../../../getx_controllers/finance/finance_controller.dart';
import '../../../models/finance/salaries.dart';
import '../../consts_widgets/gradiants.dart';
import '../../reusable_widgets/localized_text.dart';

class SalaryDetailsPage extends StatelessWidget {

   SalaryDetailsPage({Key? key,required this.baseSalary, required this.salary,}) : super(key: key);

   final SalaryOfMonth salary;
   final String baseSalary;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: greenGradiantAppBar,
        ),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: Row(
                  children: [
                    LocalizedText(
                      'salary_details',
                      textStyle: const TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: (){

                        Get.back();

                      },
                      child: Image.asset(
                        'assets/images/back_arrow_${'lang_code'.tr}.png',
                        width: 50,
                      ),
                    ) ,
                  ],
                ),
              ),
            ),
            NetSalaryWidget(
              netSalary: '${salary.salaryAfter} ${'SR'.tr}',
            ),
            Expanded(child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: (Get.height * 0.1 + 40) / 2),
                  width: double.maxFinite,
                  // height: double.maxFinite,
                  color: Colors.white,

                ),

                //
                Container(
                  margin: EdgeInsets.only(top: (Get.height * 0.1 + 40) / 2),
                  width: double.maxFinite,
                  // height: double.maxFinite,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 75,),

                        // Month and Year
                        Text('${salary.month.tr} ${salary.year.tr}',style: const TextStyle(
                            color: AppColors.darkGreyTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),),

                        // Base salary
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 30),
                          child: Row(
                            children: [
                              Text('base_salary'.tr,style: const TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const Spacer(),
                              Text(baseSalary,style: const TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const Text('+',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const SizedBox(width: 10,),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.mainGreenColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                            ],
                          ),
                        ),

                         // Allowances
                         for(int i=0; i<salary.allowances.length;i++)
                         Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 30),
                          child: Row(
                            children: [
                              Text(salary.allowances[i].allowancesType?.name ??'',style: const TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const Spacer(),
                              Text('${salary.allowances[i].amount}',style: const TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const Text('+',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const SizedBox(width: 10,),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.mainGreenColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                            ],
                          ),
                        ),

                        // discounts
                        for(int i=0; i<salary.discounts.length;i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 30),
                          child: Row(
                            children: [
                              Text('${salary.discounts[i].employeeSalaryDiscountType?.name}'.tr,style: const TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const Spacer(),
                              Text('${salary.discounts[i].amount}',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const Text('-',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const SizedBox(width: 10,),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.gradiantRed.first,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                // Total discounts
                Container(
                  width: double.maxFinite,
                  height: Get.height * 0.1,
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${salary.totalDiscountAmount} '+'SR'.tr,style: const TextStyle(
                          color: AppColors.darkGreyTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),),
                      Text('total_cuts'.tr,style: const TextStyle(
                          color: AppColors.lightGreyTextColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 15
                      ),),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),

    );
  }
}

