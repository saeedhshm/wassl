import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetSalaryWidget extends StatelessWidget {

  final String netSalary;
  const NetSalaryWidget({Key? key,required this.netSalary}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(netSalary,style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),),
        Text('net_salary'.tr,style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.normal
        ),),
      ],
    );
  }
}
