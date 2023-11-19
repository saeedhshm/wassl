import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';


abstract class DropItem{
  String get name;
  @override
  int get hashCode => name.hashCode;
  @override
  bool operator ==(o) => o is DropItem && name == o.name ;
}

class DropDownWidget<T extends DropItem> extends StatefulWidget {
  // String selectedValue;
  final Widget? prefixIcon;
  final String hintText;
  final String? errorMessage;
  final List<T> items;
  final double iconPadding;
  final Function(T?) onSelectedIndex;
  T? selectedValue;



  DropDownWidget(
      {Key? key,
      required this.hintText,
      required this.items,
      this.selectedValue,
      required this.onSelectedIndex,
      this.errorMessage,
        this.iconPadding = 8,
      this.prefixIcon})
      : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T extends DropItem> extends State<DropDownWidget<T>> {


  @override
  Widget build(BuildContext context) {
    var errors = widget.errorMessage != null && widget.errorMessage!.isNotEmpty;

    // return SizedBox();
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
                  padding:  EdgeInsets.all(widget.iconPadding),
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
                  child: Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.iconsColor,)),
              iconSize: 20,
              buttonHeight: 45,
              buttonPadding: const EdgeInsets.only(left: 8, right: 0),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: widget.items
                  .map((item) => DropdownMenuItem<T>(
                        value: item,
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                //Do something when changing the item if you want.

                widget.onSelectedIndex(value);
                setState(() {});
              },
              onSaved: (value) {
                widget.selectedValue = value;
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
