import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackArrowIcon extends StatelessWidget {

  final double width;
  final Color color;
  const BackArrowIcon({super.key,this.width = 50,this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/back_arrow_${'lang_code'.tr}.png',
      width: width,
      color: color,
    );
  }
}
