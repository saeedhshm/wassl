import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/profile/info.dart';
import 'package:wassl/views/reusable_widgets/light_text_widget.dart';
import '../../reusable_widgets/circular_widget.dart';
import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/list_profile_item_widget.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(
              top: height*1.5,
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
                SizedBox(height: 10,),
                DarkTextWidget('اسم الموظف بالكامل',fontSize: 20,),
                SizedBox(height: 0,),
                DarkTextWidget('مصمم جرافيكس',fontSize: 16,),
                SizedBox(height: 20,),
                SizedBox(width:double.infinity,child: LightTextWidget('anual_vacations',fontSize: 20,)),
                SizedBox(height: 10,),
                ListProfileItemWidget(
                  title: "رصيد الاجازات ٥ ايام متاحة الاستخدام",
                  icon: "assets/images/profile/vacation.png",
                ),
                SizedBox(height: 20,),
                SizedBox(width:double.infinity,child: LightTextWidget('profile',fontSize: 20,)),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    Get.to(()=>InfoPage());
                  },
                  child: ListProfileItemWidget(
                    title: "profile_info",
                    icon: "assets/images/profile/1.png",
                  ),
                ),
                ListProfileItemWidget(
                  title: "work_info",
                  icon: "assets/images/profile/2.png",
                ),
                ListProfileItemWidget(
                  title: "money_info",
                  icon: "assets/images/profile/3.png",
                ),
                ListProfileItemWidget(
                  title: "docs",
                  icon: "assets/images/profile/4.png",
                ),
                ListProfileItemWidget(
                  title: "contracts",
                  icon: "assets/images/profile/5.png",
                ),
                ListProfileItemWidget(
                  title: "Custodys",
                  icon: "assets/images/profile/6.png",
                ),


                SizedBox(height: 110,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
