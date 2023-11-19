import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class DropDownMenu extends StatefulWidget {


  String textHint;
  Widget? prefixIcon;
  Widget? suffixIcon;
   DropDownMenu({Key? key,required this.textHint,this.prefixIcon,this.suffixIcon}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {

  String? textTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderTextFieldColor),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: [
          widget.prefixIcon != null ? SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: widget.prefixIcon,
            ),
          ) : const SizedBox(width: 16,),
          Expanded(child: Text(textTitle ?? widget.textHint)),
          widget.suffixIcon != null ? SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: widget.suffixIcon,
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
