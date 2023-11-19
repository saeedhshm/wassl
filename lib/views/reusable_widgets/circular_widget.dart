import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class CircularWidget extends StatelessWidget {
  
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Widget child;
  final double padding;
   const CircularWidget({Key? key,required this.child,required this.size,this.borderColor = AppColors.mainGreenColor,this.borderWidth = 1, this.padding = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor,width:borderWidth ),
        borderRadius: BorderRadius.circular(size),
      ),
    );
  }
}
