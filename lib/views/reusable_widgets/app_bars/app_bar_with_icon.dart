import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';

import '../../consts_widgets/gradiants.dart';


class AppbarWithTrailingIconsWidget extends StatelessWidget {
  final String title;
  final List<Widget> childern;
  const AppbarWithTrailingIconsWidget(this.title, {Key? key, required this.childern}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    // var height = Get.statusBarHeight;
    return Container(
      width: double.infinity,
      height: 65 + height,
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Row(
            children: [
              LocalizedText(
                title,
                textStyle: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Row(children: childern,)
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        gradient: greenGradiantAppBar,
      ),
    );
  }
}