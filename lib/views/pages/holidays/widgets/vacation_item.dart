import 'package:flutter/material.dart';
import 'package:wassl/views/pages/holidays/widgets/separator.dart';

import '../../../../getx_controllers/vacations/vacation_view_model.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../reusable_widgets/icons/back_arrow.dart';


class VacationsWidget extends StatelessWidget {

  final List<VacationViewModel> vacationViewModels;

    const VacationsWidget({
    Key? key,
    required this.vacationViewModels
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: vacationViewModels.map((vacation) => _VacationWidget(vacation)).toList(),
    );
  }
}

class _VacationWidget extends StatelessWidget {

  final VacationViewModel viewModel;
  const _VacationWidget(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
            child: Row(
              children: [
                Text(viewModel.vacationTypeName),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.borderTextFieldColor,width: 0.5),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 3),
                    child: Text(viewModel.countInDays),
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
                Text(viewModel.vacationStartsIn),
                const BackArrowIcon( width: 35,
                  color: AppColors.darkGreyTextColor,),
                Text(viewModel.vacationEndsIn),
              ],
            ),
          ),
        ),
        const SeparatorWidget(),
      ],
    );
  }
}
