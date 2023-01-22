import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/home/home_controller.dart';

class HomeBarWidget extends StatelessWidget {

  final HomeController controller = Get.find();

   HomeBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 45,
              bottom: 20,
              left: 16,
              right: 16
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('welcome'.tr +' : ',style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
                  Text(controller.appController.loginModel.value.user!.fullName!,style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const Spacer(),
              SizedBox(height: 35,width:55,child: Image.asset('assets/images/settingicons/12.png',color: Colors.white,)),
            ],
          ),
        ),
        Container(color: Colors.white,width: double.maxFinite,height: 0.5,),
      ],
    );
  }
}
