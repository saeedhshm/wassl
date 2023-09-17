import 'package:flutter/material.dart';

import '../../../helpers/constants/app_colors.dart';

class EditIcon extends StatelessWidget {

  final Color? color;
  const EditIcon({super.key,this.color = AppColors.iconsColor});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/edit.png',color: color,);
  }
}
