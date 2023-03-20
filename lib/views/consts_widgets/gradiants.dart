import 'package:flutter/material.dart';

import '../../helpers/constants/app_colors.dart';

LinearGradient get greenGradiantAppBar{
  return const LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: AppColors.gradiantGreen,
  );


}


LinearGradient get greenGradiantAppBarSecond{
  return const LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: AppColors.gradiantGreenSecond,
  );


}

LinearGradient get redGradiantCancel{
  return const LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: AppColors.gradiantRed,
  );}

LinearGradient get grayGradiantAwait{
  return const LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: AppColors.gradiantGray,
  );}