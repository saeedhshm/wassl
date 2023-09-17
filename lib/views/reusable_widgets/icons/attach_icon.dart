
import 'package:flutter/material.dart';

import '../../../helpers/constants/app_colors.dart';

class AttachmentIcon extends StatelessWidget {

  final Color? color;
  const AttachmentIcon({super.key,this.color = AppColors.iconsColor});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/attach.png',color: color,);
  }
}
