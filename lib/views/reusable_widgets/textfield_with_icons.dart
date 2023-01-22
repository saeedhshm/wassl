import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class TextFormFieldWithIcons extends StatelessWidget {

  final String hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool secureText;
  final String? errorMessage;
  final TextEditingController? controller;
  final bool isValideField;
  final int maxLines;
  final bool readOnly;
  final  TextInputType keyboardType;
  final Function (String)?onFieldSubmitted;
  final Function (String)?onChange;
  final TextCapitalization textCapitalization;
  final double height;

  TextFormFieldWithIcons({Key? key,this.height = 50,this.maxLines = 1,this.prefixIcon,required this.hintText,this.labelText,this.suffixIcon,this.secureText = false,this.isValideField = true,this.errorMessage,this.controller,this.keyboardType = TextInputType.text,this.onFieldSubmitted,this.onChange,this.readOnly = false,this.textCapitalization =  TextCapitalization.none}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height,
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              prefixIcon != null ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(child: prefixIcon!,width: 35,),
              ) : SizedBox(),
              Expanded(child: TextFormField(
                controller: controller,
                readOnly: readOnly,
                obscuringCharacter: '⋆',
                obscureText: secureText,
                maxLines: maxLines,
                keyboardType: keyboardType,
                textCapitalization:textCapitalization,
                onFieldSubmitted: onFieldSubmitted,
                onChanged: onChange,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(
                    bottom: 8,
                    right: 10,
                    left: 10
                  ),
                  hintText: hintText.tr,
                  hintStyle: TextStyle(color: isValideField ? Colors.grey : Colors.red,backgroundColor: Colors.white),
                  label:labelText == null ? null : Text(labelText!.tr,style: TextStyle(color:isValideField ? AppColors.lightGreyTextColor : Colors.red,backgroundColor: Colors.white),),

                ),
                // validator: (value){
                //        return value == '' ? '' : null;
                // },
              )),
              suffixIcon != null ? suffixIcon! : SizedBox()
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 1,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
        ),
        isValideField ? SizedBox() : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(errorMessage ?? '',style: TextStyle(
              color: Colors.red,
              fontSize: 14
          ),),
        )
      ],
    );
  }
}
