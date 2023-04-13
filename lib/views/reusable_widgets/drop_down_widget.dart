import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../../helpers/constants/print_ln.dart';

class DropDownWidget extends StatefulWidget {
  // String selectedValue;
  final Widget? prefixIcon;
  final String hintText;
  final String? errorMessage;
  final List<String> items;
  final Function(int) onSelectedIndex;
  String? selectedValue;



  DropDownWidget(
      {Key? key,
      required this.hintText,
      required this.items,
      this.selectedValue,
      required this.onSelectedIndex,
      this.errorMessage,
      this.prefixIcon})
      : super(key: key) {}

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    var errors = widget.errorMessage != null && widget.errorMessage!.isNotEmpty;
    // println('--===--- selectedValue is ${widget.selectedValue}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: DropdownButtonFormField2(
              value: widget.selectedValue,
              decoration: InputDecoration(
                hintText: widget.hintText,
                fillColor: Colors.white,

                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.prefixIcon,
                ),
                // prefixIconConstraints: BoxConstraints(maxWidth: 400),
                suffixIconColor: AppColors.borderTextFieldColor,
                focusColor: AppColors.mainGreenColor,

                filled: true,
                contentPadding: const EdgeInsets.only(
                    left: 0, bottom: 10, top: 0, right: 0),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: errors
                            ? Colors.red
                            : AppColors.borderTextFieldColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(15)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: errors
                            ? Colors.red
                            : AppColors.borderTextFieldColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(15)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: errors
                            ? Colors.red
                            : AppColors.borderTextFieldColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(15)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: errors
                            ? Colors.red
                            : AppColors.borderTextFieldColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(15)),
              ),
              isExpanded: true,
              hint: Text(
                widget.hintText,
                style: const TextStyle(fontSize: 14),
              ),
              icon: const SizedBox(
                width: 25,
                  child: Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.lightGreyTextColor,)),
              iconSize: 20,
              buttonHeight: 45,
              buttonPadding: const EdgeInsets.only(left: 8, right: 0),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: widget.items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                //Do something when changing the item if you want.

                widget.onSelectedIndex(widget.items.indexOf(value.toString()));
                setState(() {});
              },
              onSaved: (value) {
                widget.selectedValue = value.toString();
              },
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          errors
              ? Text(
                  widget.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 15),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
