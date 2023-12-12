import 'package:flutter/material.dart';

import '../../helpers/constants/app_colors.dart';

class SendingLoadingWidget extends StatelessWidget {
  const SendingLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class WaitingRequestLoadingWidget extends StatelessWidget {
  const WaitingRequestLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.mainGreenColor)),
      ),
    );
  }
}
