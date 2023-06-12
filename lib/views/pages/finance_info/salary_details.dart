import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../../../getx_controllers/finance/all_salaries.dart';
import '../../../getx_controllers/finance/finance_controller.dart';
import '../../consts_widgets/gradiants.dart';
import '../../reusable_widgets/localized_text.dart';

class SalaryDetailsPage extends StatelessWidget {

   SalaryDetailsPage({Key? key}) : super(key: key);

  final AllSalariesController controller = Get.put(AllSalariesController());
  final FinanceInfoController financeInfoController = Get.find<FinanceInfoController>();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
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
                        Get.delete<FinanceInfoController>();
                        Get.back();

                      },
                      child: Image.asset(
                        'assets/images/back_arrow.png',
                        width: 50,
                      ),
                    ) ,
                  ],
                ),
              ),
            ),
            Text('${financeInfoController.finance.salaryAfter} ${'SR'.tr}',style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),),
            Text('net_salary'.tr,style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.normal
            ),),
            Expanded(child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: (Get.height * 0.1 + 40) / 2),
                  width: double.maxFinite,
                  // height: double.maxFinite,
                  color: Colors.white,

                ),
                Container(
                  margin: EdgeInsets.only(top: (Get.height * 0.1 + 40) / 2),
                  width: double.maxFinite,
                  // height: double.maxFinite,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 60,),
                        const Text('يناير 2023',style: TextStyle(
                            color: AppColors.darkGreyTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),),
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
                              Text('${financeInfoController.finance.employee?.salary}',style: const TextStyle(
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
                         for(int i=0; i<financeInfoController.finance.allowances.length;i++)
                         Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 30),
                          child: Row(
                            children: [
                              Text(financeInfoController.finance.allowances[i].allowanceType?.name ??'',style: const TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const Spacer(),
                              Text('${financeInfoController.finance.allowances[i].amount}',style: const TextStyle(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 30),
                          child: Row(
                            children: [
                              Text('moving_allowance'.tr,style: const TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const Spacer(),
                              const Text('500',style: TextStyle(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 30),
                          child: Row(
                            children: [
                              Text('delay_discount'.tr,style: const TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              const Spacer(),
                              const Text('10000',style: TextStyle(
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
                Container(
                  width: double.maxFinite,
                  height: Get.height * 0.1,
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('1000 '+'SR'.tr,style: const TextStyle(
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

    ), onWillPop: ()async{
      Get.delete<FinanceInfoController>();
      return true;
    });
  }
}
