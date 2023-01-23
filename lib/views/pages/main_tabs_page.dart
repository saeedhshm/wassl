import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/views/pages/orders/requests_page.dart';
import 'package:wassl/views/pages/profile/user_profile.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

import '../../getx_controllers/calendar/calendar_controller.dart';
import 'attendance/attendance_form.dart';
import 'home/home_page.dart';
import 'orders/pages/loan_order.dart';
import 'orders/previous_orders/page.dart';

class MainTabsPage extends StatefulWidget {
  const MainTabsPage({Key? key}) : super(key: key);

  @override
  State<MainTabsPage> createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage> {

  int _index = 3;
  final CalendarController calendarController =  Get.put(CalendarController());
  var pages = [
     UserProfilePage(),
    // Center(child: PerviuosRequestsPage(),),
    AttendancePage(),
    Center(child: HomePage(),),
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.bottom;
    // var height = Get.bottomBarHeight;
    print("height ----->>> $height");
    return Scaffold(
      body: Stack(
        children: [
         pages[_index-1],
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
                                  _index = 3;
                                  setState((){});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgWidget("assets/images/bottom_nav/${_index == 3 ? 'active' : ''}4.svg"),
                                ),
                              )),
                          Expanded(
                              child:
                              GestureDetector(
                                onTap: (){
                                  _index = 2;

                                  setState((){});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgWidget("assets/images/bottom_nav/${_index == 2 ? 'active' : ''}3.svg"),
                                ),
                              )),
                          // Spacer(),
                          // Expanded(
                          //     child:
                          //     GestureDetector(
                          //       onTap: (){
                          //         _index = 2;
                          //
                          //         setState((){});
                          //       },
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(12.0),
                          //         child: SvgWidget("assets/images/bottom_nav/${_index == 2 ? 'active' : ''}2.svg"),
                          //       ),
                          //     )),
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
                  // Align(
                  //   alignment: FractionalOffset.topCenter,
                  //   child: InkWell(
                  //     onTap: (){
                  //       Get.to(()=>const RequestsPage());
                  //     },
                  //     child: Container(
                  //       height: 65,
                  //       width: 65,
                  //       child: const Padding(
                  //         padding: EdgeInsets.all(15.0),
                  //         child: SvgWidget('assets/images/bottom_nav/plus.svg'),
                  //       ),
                  //       decoration: BoxDecoration(
                  //           gradient: const LinearGradient(
                  //             begin: Alignment.centerRight,
                  //             end: Alignment.centerLeft,
                  //             colors: AppColors.gradiantGreen,
                  //           ),
                  //           borderRadius: BorderRadius.circular(100)),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
