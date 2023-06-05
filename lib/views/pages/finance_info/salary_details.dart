import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../getx_controllers/finance/all_salaries.dart';
import '../../consts_widgets/gradiants.dart';
import '../../reusable_widgets/localized_text.dart';

class SalaryDetailsPage extends StatelessWidget {

   SalaryDetailsPage({Key? key}) : super(key: key);

  final AllSalariesController controller = Get.put(AllSalariesController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,

            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: Row(
                  children: [
                    LocalizedText(
                      'salary_details',
                      textStyle: const TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
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
            decoration: BoxDecoration(
              gradient: greenGradiantAppBar,
            ),
          )
        ],
      ),
    );
  }
}
