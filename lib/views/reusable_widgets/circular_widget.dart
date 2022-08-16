import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class CircularWidget extends StatelessWidget {
  
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Widget child;
   CircularWidget({Key? key,required this.child,required this.size,this.borderColor = AppColors.mainGreenColor,this.borderWidth = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: child,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor,width:borderWidth ),
        borderRadius: BorderRadius.circular(size)
      ),
    );
  }
}
