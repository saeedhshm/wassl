import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../../../getx_controllers/finance/all_salaries.dart';
import '../../consts_widgets/gradiants.dart';
import '../../reusable_widgets/localized_text.dart';

class SalaryDetailsPage extends StatelessWidget {

   SalaryDetailsPage({Key? key}) : super(key: key);

  final AllSalariesController controller = Get.put(AllSalariesController());


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
                      child: Container(
                          child: Image.asset(
                            'assets/images/back_arrow.png',
                            width: 50,
                          )),
                    ) ,
                  ],
                ),
              ),
            ),
            Text('11,500',style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),),
            Text('net_salary'.tr,style: TextStyle(
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
                        SizedBox(height: 60,),
                        Text('يناير 2023',style: TextStyle(
                            color: AppColors.darkGreyTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 30),
                          child: Row(
                            children: [
                              Text('base_salary'.tr,style: TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              Spacer(),
                              Text('10000',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              Text('+',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              SizedBox(width: 10,),
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
                              Text('home_allowance'.tr,style: TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              Spacer(),
                              Text('2000',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              Text('+',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              SizedBox(width: 10,),
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
                              Text('moving_allowance'.tr,style: TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              Spacer(),
                              Text('500',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              Text('-',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              SizedBox(width: 10,),
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
                              Text('delay_discount'.tr,style: TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              Spacer(),
                              Text('10000',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              Text('-',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                              ),),
                              SizedBox(width: 10,),
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
                      Text('1000 '+'SR'.tr,style: TextStyle(
                          color: AppColors.darkGreyTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),),
                      Text('total_cuts'.tr,style: TextStyle(
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
