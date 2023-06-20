import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/holidays/widgets/separator.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../models/holidays/vacations.dart';


class VacationItemWidget extends StatelessWidget {

  final List<Vacation> vacations;
   const VacationItemWidget({
    Key? key,
    required this.vacations
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: vacations.map((e) => Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              child: Row(
                children: [
                  Text('${e.type?.name}'),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.borderTextFieldColor,width: 0.5),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 3),
                      child: Text('${e.count} ${'days'.tr}'),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SeparatorWidget(),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${e.holidayStart}'),
                  Image.asset(
                    'assets/images/back_arrow.png',
                    width: 35,
                    color: AppColors.darkGreyTextColor,
                  ),
                  Text('${e.holidayEnd}'),
                ],
              ),
            ),
          ),
          const SeparatorWidget(),
        ],
      )).toList(),
    );
  }
}