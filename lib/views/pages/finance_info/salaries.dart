import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/finance/all_salaries.dart';
import 'package:wassl/views/pages/finance_info/salary_details.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/light_text_widget.dart';
import '../../reusable_widgets/main_appbar.dart';

class AllSalariesPage extends StatelessWidget {

   AllSalariesPage({Key? key}) : super(key: key);

   final AllSalariesController controller = Get.put(AllSalariesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget("salaries",onBack: (){
            Get.back();
          },),
          Expanded(child: Container(
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
                        DarkTextWidget('base_salary',fontSize: 17,),
                        LightTextWidget('10000 ' + 'SR'.tr,fontSize: 15,),
                      ],
                    ),
                  ),),
              const SizedBox(height: 16,),
                  Expanded(child: ListView.separated(
                      padding:  const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (_,index){
                        return InkWell(
                          onTap: (){
                            Get.to(SalaryDetailsPage());
                          },
                          child: ShadowedWidget(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text('يناير'.tr, style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColors.darkGreyTextColor
                                    ),),
                                    Text('2023'.tr, style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: AppColors.darkGreyTextColor
                                    ),)
                                  ],
                                ),

                                const Spacer(),
                                Text('11500 '+'SR'.tr, style: const TextStyle(
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
                      itemCount: 10))
                ],
              ),
            ),
          ))

        ],
      ),
    );
  }
}

class ShadowedWidget extends StatelessWidget {

  final Widget child;

  const ShadowedWidget({
    Key? key,
    required this.child,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: child,
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
    );
  }
}
