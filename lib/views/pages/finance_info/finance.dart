import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/finance/finance_controller.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/light_text_widget.dart';
import '../../reusable_widgets/main_appbar.dart';

class FinanceInfoPage extends StatelessWidget {

  final controller = Get.put(FinanceInfoController());
  var items = [];

  FinanceInfoPage({Key? key}) : super(key: key){
    items = [
      // ValuesOfInfoPage(title: 'job_code'.tr, value: appController.loginModel.value.user?.code ?? ''),
      // ValuesOfInfoPage(title: 'full_name'.tr, value: appController.loginModel.value.user?.fullName ?? ''),
      // // ValuesOfInfoPage(title: 'الاسم الأخير', value: 'هاشم'),
      // ValuesOfInfoPage(title: 'email'.tr, value: appController.loginModel.value.user?.email ?? ''),
      // ValuesOfInfoPage(title: 'date_of_birth'.tr, value: appController.loginModel.value.user?.dateOfBirth ?? ''),
      // ValuesOfInfoPage(title: 'mobile_number'.tr, value: appController.loginModel.value.user?.number ?? ''),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget("personal",onBack: (){
            Get.back();
          },),
          Expanded(child:Obx(()=>controller.loading.value ? const Center(
            child: SendingLoadingWidget(),
          ) :  SingleChildScrollView(
            child: Padding(
              padding:  const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: ,),

                  const SizedBox(height: 16,),
                  const DarkTextWidget("money_info",fontSize: 24,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5,),
                      const LightTextWidget('base_salary',fontSize: 17,),
                      const SizedBox(height: 3,),
                      DarkTextWidget(controller.finance.employee?.salary ?? '',fontSize: 17,),
                      const SizedBox(height: 5,),
                      const Divider()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 5,),
                      LightTextWidget('insurance_pension',fontSize: 17,),
                      SizedBox(height: 3,),
                      DarkTextWidget('---',fontSize: 17,),
                      SizedBox(height: 5,),
                      Divider()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5,),
                      const LightTextWidget('total_salary',fontSize: 17,),
                      const SizedBox(height: 3,),
                      DarkTextWidget('${controller.finance.salaryAfter}',fontSize: 17,),
                      const SizedBox(height: 5,),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 16,),
                  const DarkTextWidget("frequent_allowances",fontSize: 24,),
                  for(int i=0;i<controller.finance.allowances.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        LightTextWidget('${controller.finance.allowances[i].allowanceType?.name}',fontSize: 17,),
                        const SizedBox(height: 3,),
                        DarkTextWidget('${controller.finance.allowances[i].amount}',fontSize: 17,),
                        const SizedBox(height: 5,),
                        const Divider()
                      ],
                    ),
                ],
              ),
            ),
          )))
        ],
      ),
    );
  }
}
class ValuesOfInfoPage{
  String? title;
  String? value;
  ValuesOfInfoPage({this.title,this.value});
}