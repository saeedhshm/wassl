import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class DocIcon extends StatelessWidget {

  final Color? color;
  const DocIcon({this.color = AppColors.mainOrangeColor,super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/prosedures/docs.png',color: color,);
  }
}
