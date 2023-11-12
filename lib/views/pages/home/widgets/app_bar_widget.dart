import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/localized_text.dart';

class HomeBarWidget extends StatelessWidget {

  final HomeController controller = Get.find();

   HomeBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    println(AppUrls.appDomain,'AppUrls.appDomain');
    return  Column(
      children: [
        Container(
          width: double.infinity,
          height: 65 + height,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Row(
                children: [
                  LocalizedText(
                    'welcome'.tr +' : ' + controller.appController.loginModel.value.user!.fullName + ' ' + (AppUrls.appDomain == 'https://waslhr.com' ? '' : ' (تجربة)'),
                    textStyle: const TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  SizedBox(height: 35,width:35,child: Image.asset('assets/images/settingicons/12.png',color: Colors.white,)),

                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
            gradient: greenGradiantAppBar,
          ),
        ),

        Container(color: Colors.white,width: double.maxFinite,height: 0.5,),
      ],
    );
  }
}
