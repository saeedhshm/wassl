import 'package:flutter/material.dart';

import 'localized_text.dart';

class MainTitleText extends StatelessWidget {

  final String text;
   const MainTitleText(this.text,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalizedText(text,textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.w400
    ),);
  }
}
