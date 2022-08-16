import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {

  final String hintText;
  final String? labelText;
  final Widget? icon;
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

   CustomTextFormField({Key? key,this.maxLines = 1,required this.hintText,this.labelText,this.icon,this.secureText = false,this.isValideField = true,this.errorMessage,this.controller,this.keyboardType = TextInputType.text,this.onFieldSubmitted,this.onChange,this.readOnly = false,this.textCapitalization =  TextCapitalization.none}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(

          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            obscureText: secureText,
            maxLines: maxLines,
            keyboardType: keyboardType,
            textCapitalization:textCapitalization,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChange,
            decoration: InputDecoration(

                focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),

                    borderSide: BorderSide(
                      color:isValideField ?  AppColors.borderTextFieldColor: Colors.red,

                    )),

                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      // color: Colors.red
                      color:isValideField ? AppColors.borderTextFieldColor : Colors.red,
                    )),

                fillColor: Colors.white,
                filled: true,

                hintText: hintText.tr,
                hintStyle: TextStyle(color: isValideField ? AppColors.lightGreyTextColor : Colors.red,backgroundColor: Colors.white),
                label:labelText == null ? null : Text(labelText!.tr,style: TextStyle(color:isValideField ? AppColors.lightGreyTextColor : Colors.red,backgroundColor: Colors.white),),
                suffixIcon:icon
            ),
            // validator: (value){
            //        return value == '' ? '' : null;
            // },
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
