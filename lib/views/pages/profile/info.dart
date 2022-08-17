import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../reusable_widgets/circular_widget.dart';
import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/light_text_widget.dart';

class InfoPage extends StatelessWidget {

  var items = [
    ValuesOfInfoPage(title: 'الرقم الوظيفي', value: '12054'),
    ValuesOfInfoPage(title: 'الاسم الأول', value: 'سعيد'),
    ValuesOfInfoPage(title: 'الاسم الأخير', value: 'هاشم'),
    ValuesOfInfoPage(title: 'البريد الإلكتروني', value: 'email@email.com'),
    ValuesOfInfoPage(title: 'تاريخ الميلاد', value: '12/12/1212'),
    ValuesOfInfoPage(title: 'رقم الهاتف', value: '012333665555'),
  ];
   InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget("personal"),
          Expanded(child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16
              ),
              child: Column(
                children: [
                  // SizedBox(height: ,),
                  CircularWidget(
                    size: 130,
                    child: Image.asset('assets/images/profile/1.png'),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      DarkTextWidget("general_info",fontSize: 24,),
                      Spacer(),
                      InkWell(onTap: (){

                      },child: Image.asset("assets/images/profile/edit_profile.png",width: 30,)),

                    ],
                  ),
                  for(int i=0;i<items.length;i++)
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          LightTextWidget(items[i].title!,fontSize: 17,),
                          // SizedBox(height: 10,),
                          DarkTextWidget(items[i].value!,fontSize: 17,),
                          SizedBox(height: 5,),
                          Divider()
                        ],
                      ),
                    )

                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class ValuesOfInfoPage{
  String? title;
  String? value;
  ValuesOfInfoPage({this.title,this.value});
}
