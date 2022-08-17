import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/profile/user_profile.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

class MainTabsPage extends StatefulWidget {
  const MainTabsPage({Key? key}) : super(key: key);

  @override
  State<MainTabsPage> createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.bottom;
    // var height = Get.bottomBarHeight;
    print("height ----->>> $height");
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: const UserProfilePage()),
          Container(
// color:Colors.red,
            height: 100,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25, left: 16, right: 16, bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Expanded(
                            child:
                                Image.asset("assets/images/bottom_nav/4.png")),
                        Expanded(
                            child:
                                Image.asset("assets/images/bottom_nav/2.png")),
                        Spacer(),
                        Expanded(
                            child:
                                Image.asset("assets/images/bottom_nav/1.png")),
                        Expanded(
                            child: Image.asset(
                          "assets/images/bottom_nav/3.png",
                          color: AppColors.mainGreenColor,
                        )),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgWidget('assets/images/bottom_nav/plus.svg'),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: AppColors.gradiantGreen,
                        ),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
