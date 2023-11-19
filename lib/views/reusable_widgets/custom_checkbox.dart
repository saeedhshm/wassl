import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import 'localized_text.dart';

class CustomCheckbox extends StatefulWidget {
  final String title;
  final Function (bool)onChanged;
   const CustomCheckbox({Key? key,required this.title,required this.onChanged}) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        isChecked = !isChecked;
        widget.onChanged(isChecked);
        setState((){});
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            child:isChecked ? const Padding(
              padding: EdgeInsets.all(2.0),
              child: Center(child: Icon(Icons.check,color: Colors.white,size: 18,)),
            ) : null,
            decoration: BoxDecoration(
              color: isChecked ? AppColors.mainGreenColor : Colors.transparent,
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color:isChecked ? Colors.transparent : AppColors.borderTextFieldColor,width: isChecked ? 0 : 1)
            ),
          ),
          const SizedBox(width: 10,),
          LocalizedText(widget.title,textStyle: const TextStyle(
            fontSize: 15,
              color: AppColors.darkGreyTextColor
          ),)
        ],
      ),
    );
  }
}
