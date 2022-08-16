import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/constants/app_colors.dart';

class MainButtonWidget extends StatelessWidget {

  final String btnTitle;
  final Function ()onPressed;
   MainButtonWidget({Key? key,required this.btnTitle,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(btnTitle.tr,
              style: TextStyle(color: Colors.white,fontSize: 18),
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: AppColors.mainGreenColor,
            borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}
