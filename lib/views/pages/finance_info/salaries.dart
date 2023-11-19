import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/finance/all_salaries.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/finance_info/salary_details.dart';

import '../../../getx_controllers/finance/salary_month_view_model.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/light_text_widget.dart';
import '../../reusable_widgets/main_appbar.dart';
import '../../reusable_widgets/shadowed_widget.dart';

class AllSalariesPage extends StatelessWidget {

   AllSalariesPage({Key? key}) : super(key: key);

   final AllSalariesViewModel controller = Get.put(AllSalariesViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget("salaries",onBack: (){
            Get.back();
          },),
          Expanded(child: Obx(()=> controller.loading.value ? const Center(
            child: SendingLoadingWidget(),
          ) : Container(
            color: AppColors.lightBackgroundColor,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ShadowedWidget(child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const DarkTextWidget('base_salary',fontSize: 17,),
                        LightTextWidget(controller.baseSalary,fontSize: 15,),
                      ],
                    ),
                  ),),
                  const SizedBox(height: 16,),
                  Expanded(child: ListView.separated(
                      padding:  const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (_,index){
                        SalaryOfMonthViewModel salary = controller.salaries[index];
                        return InkWell(
                          onTap: (){

                            Get.to(SalaryDetailsPage(salary:salary.salary, ));
                          },
                          child: ShadowedWidget(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(salary.salaryMonth, style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColors.darkGreyTextColor
                                    ),),
                                    Text(salary.salaryYear, style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: AppColors.darkGreyTextColor
                                    ),)
                                  ],
                                ),

                                const Spacer(),
                                Text(salary.salaryAfter, style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColors.darkGreyTextColor
                                ),)
                              ],
                            ),
                          )),
                        );
                      },
                      separatorBuilder: (_,index){
                        return const SizedBox(height: 16,);
                      },
                      itemCount: controller.salaries.length))
                ],
              ),
            ),
          )))

        ],
      ),
    );
  }
}


