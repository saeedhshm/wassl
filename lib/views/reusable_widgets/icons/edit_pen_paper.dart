import 'package:flutter/cupertino.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class EditBenOnPaperIcon extends StatelessWidget {

  final Color? color;
  const EditBenOnPaperIcon({this.color = AppColors.mainOrangeColor,super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/prosedures/orders.png',color: color,);
  }
}
