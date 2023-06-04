import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/finance/finance_controller.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../reusable_widgets/main_appbar.dart';

class FinanceInfoPage extends StatelessWidget {

  final controller = Get.put(FinanceInfoController());


  FinanceInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            "money_info",
            onBack: () {
              Get.back();
            },
          ),
          const SizedBox(height: 40,),
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 40,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 50,),
                              Text('${controller.appController.loginModel.value.user?.fullName}',style: const TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                              ),),
                              Text('${controller.appController.loginModel.value.user?.job?.name}',style: const TextStyle(
                                color: AppColors.lightGreyTextColor,
                                // fontSize: 12
                              ),),
                              const SizedBox(height: 20,),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width:80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0,0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Image.asset('assets/images/profile/1.png')),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
