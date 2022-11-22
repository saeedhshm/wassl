import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/orders/new_order.dart';
import 'package:wassl/views/pages/profile/user_profile.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

class MainTabsPage extends StatefulWidget {
  const MainTabsPage({Key? key}) : super(key: key);

  @override
  State<MainTabsPage> createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage> {

  int _index = 1;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.bottom;
    // var height = Get.bottomBarHeight;
    print("height ----->>> $height");
    return Scaffold(
      body: Stack(
        children: [
          const UserProfilePage(),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(

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
                              GestureDetector(
                                onTap: (){
                                  _index = 4;
                                  setState((){});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgWidget("assets/images/bottom_nav/${_index == 4 ? 'active' : ''}4.svg"),
                                ),
                              )),
                          Expanded(
                              child:
                              GestureDetector(
                                onTap: (){
                                  _index = 3;
                                  setState((){});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgWidget("assets/images/bottom_nav/${_index == 3 ? 'active' : ''}3.svg"),
                                ),
                              )),
                          Spacer(),
                          Expanded(
                              child:
                              GestureDetector(
                                onTap: (){
                                  _index = 2;
                                  setState((){});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgWidget("assets/images/bottom_nav/${_index == 2 ? 'active' : ''}2.svg"),
                                ),
                              )),
                          Expanded(
                              child:  GestureDetector(
                                onTap: (){
                                  _index = 1;
                                  setState((){});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgWidget(
                            "assets/images/bottom_nav/${_index == 1 ? 'active' : ''}1.svg",

                          ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.topCenter,
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>NewOrder());
                      },
                      child: Container(
                        height: 65,
                        width: 65,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
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
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
