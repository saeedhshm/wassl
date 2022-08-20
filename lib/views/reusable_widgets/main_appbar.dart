import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';

import '../../helpers/constants/app_colors.dart';

class MainAppbarWidget extends StatelessWidget {
  final String title;
  Function? onBack;
  MainAppbarWidget(this.title, {Key? key, this.onBack}) : super(key: key);

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
                textStyle: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
              ),
              Spacer(),
              InkWell(
                onTap: (){
                  if(onBack != null){
                    onBack!();
                  }else{
                    Get.back();
                  }
                },
                child: Container(
                    child: Image.asset(
                      'assets/images/back_arrow.png',
                      width: 50,
                    )),
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(  gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: AppColors.gradiantGreen,
      ),),
    );
  }
}
