import 'package:flutter/material.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/print_ln.dart';


class CustomRadioButton<T> extends StatefulWidget {

  final void Function(T) onChanged;
  final T value;
  final T groupValue;

  const CustomRadioButton({super.key,required this.onChanged,required this.value,required this.groupValue});

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState<T>();
}
class _CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {



  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: Container(
        width: 24, // adjust the size as per your requirement
        height: 24, // adjust the size as per your requirement
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.groupValue == widget.value ? AppColors.mainGreenColor : Colors.transparent,
          border: Border.all(
            color: AppColors.borderTextFieldColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}