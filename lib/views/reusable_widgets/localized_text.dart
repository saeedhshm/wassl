import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizedText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
   const LocalizedText(this.text,{Key? key,this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text.tr,style: textStyle,);
  }
}
